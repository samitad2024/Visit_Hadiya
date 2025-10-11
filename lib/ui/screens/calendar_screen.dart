import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../controllers/festival_controller.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/festival_card.dart';
import 'festival_detail_screen.dart';

class CalendarScreen extends StatelessWidget {
  final bool showAppBar;

  const CalendarScreen({super.key, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FestivalController()..load(),
      child: _CalendarView(showAppBar: showAppBar),
    );
  }
}

class _CalendarView extends StatelessWidget {
  final bool showAppBar;

  const _CalendarView({this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final c = context.watch<FestivalController>();
    final monthLabel = DateFormat('MMMM yyyy').format(c.visibleMonth);

    return Scaffold(
      appBar: showAppBar ? AppBar(title: Text(loc.t('calendar_title'))) : null,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          // Month header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: c.prevMonth,
                icon: const Icon(Icons.chevron_left_rounded),
              ),
              Text(
                monthLabel,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              IconButton(
                onPressed: c.nextMonth,
                icon: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _CalendarGrid(),
          const SizedBox(height: 20),
          Text(
            loc.t('upcoming_events'),
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          if (c.eventsThisMonth.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Text(
                  'No events this month',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            )
          else
            AnimationLimiter(
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 375),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: c.eventsThisMonth
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: FestivalCard(
                            festival: e,
                            compact: true,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FestivalDetailScreen(festival: e),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.watch<FestivalController>();
    final firstDayOfMonth = DateTime(
      c.visibleMonth.year,
      c.visibleMonth.month,
      1,
    );
    final weekdayOffset = (firstDayOfMonth.weekday % 7); // 0 for Sunday
    final daysInMonth = DateTime(
      c.visibleMonth.year,
      c.visibleMonth.month + 1,
      0,
    ).day;
    final totalCells = weekdayOffset + daysInMonth;
    final rows = (totalCells / 7.0).ceil();
    return Column(
      children: [
        const Row(
          children: [
            _Dow('S'),
            _Dow('M'),
            _Dow('T'),
            _Dow('W'),
            _Dow('T'),
            _Dow('F'),
            _Dow('S'),
          ],
        ),
        const SizedBox(height: 8),
        for (int r = 0; r < rows; r++)
          Row(
            children: [
              for (int cIdx = 0; cIdx < 7; cIdx++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: _Cell(
                      dayNumber: r * 7 + cIdx - weekdayOffset + 1,
                      visibleMonth: c.visibleMonth,
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({required this.dayNumber, required this.visibleMonth});
  final int dayNumber;
  final DateTime visibleMonth;

  @override
  Widget build(BuildContext context) {
    final c = context.watch<FestivalController>();
    if (dayNumber < 1 ||
        dayNumber >
            DateTime(visibleMonth.year, visibleMonth.month + 1, 0).day) {
      return const SizedBox.shrink();
    }
    final date = DateTime(visibleMonth.year, visibleMonth.month, dayNumber);
    final isSelected =
        c.selectedDate != null &&
        c.selectedDate!.year == date.year &&
        c.selectedDate!.month == date.month &&
        c.selectedDate!.day == date.day;
    final isFestival = c.isFestivalDay(date);
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => c.select(date),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: isSelected
                ? cs.primary
                : (isFestival ? cs.primary.withValues(alpha: 0.08) : null),
            borderRadius: BorderRadius.circular(22),
          ),
          alignment: Alignment.center,
          child: Text(
            '$dayNumber',
            style: TextStyle(
              color: isSelected ? Colors.white : null,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _Dow extends StatelessWidget {
  const _Dow(this.label);
  final String label;
  @override
  Widget build(BuildContext context) => Expanded(
    child: Center(
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
