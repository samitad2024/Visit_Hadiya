import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../controllers/festival_controller.dart';
import '../../l10n/app_localizations.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FestivalController()..load(),
      child: const _CalendarView(),
    );
  }
}

class _CalendarView extends StatelessWidget {
  const _CalendarView();
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final c = context.watch<FestivalController>();
    final monthLabel = DateFormat('MMMM yyyy').format(c.visibleMonth);
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('calendar_title'))),
      bottomNavigationBar: const NavigationBar(
        selectedIndex: 0,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.bookmark_border_rounded), label: 'Saved'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
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
              Text(monthLabel, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              IconButton(
                onPressed: c.nextMonth,
                icon: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _CalendarGrid(),
          const SizedBox(height: 20),
          Text(loc.t('upcoming_events'), style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          ...c.upcoming.map((e) => _EventTile(title: loc.t(e.titleKey), date: DateFormat('MMMM d, yyyy').format(e.date))).toList(),
        ],
      ),
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.watch<FestivalController>();
    final cs = Theme.of(context).colorScheme;
    final firstDayOfMonth = DateTime(c.visibleMonth.year, c.visibleMonth.month, 1);
    final weekdayOffset = (firstDayOfMonth.weekday % 7); // 0 for Sunday
    final daysInMonth = DateTime(c.visibleMonth.year, c.visibleMonth.month + 1, 0).day;
    final totalCells = weekdayOffset + daysInMonth;
    final rows = (totalCells / 7.0).ceil();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _Dow('S'), _Dow('M'), _Dow('T'), _Dow('W'), _Dow('T'), _Dow('F'), _Dow('S'),
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
    if (dayNumber < 1 || dayNumber > DateTime(visibleMonth.year, visibleMonth.month + 1, 0).day) {
      return const SizedBox.shrink();
    }
    final date = DateTime(visibleMonth.year, visibleMonth.month, dayNumber);
    final isSelected = c.selectedDate != null &&
        c.selectedDate!.year == date.year && c.selectedDate!.month == date.month && c.selectedDate!.day == date.day;
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
            color: isSelected ? cs.primary : (isFestival ? cs.primary.withOpacity(0.08) : null),
            borderRadius: BorderRadius.circular(22),
          ),
          alignment: Alignment.center,
          child: Text(
            '$dayNumber',
            style: TextStyle(color: isSelected ? Colors.white : null, fontWeight: FontWeight.w600),
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
  Widget build(BuildContext context) => Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.brown.shade400));
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.title, required this.date});
  final String title;
  final String date;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(color: cs.primary.withOpacity(0.12), borderRadius: BorderRadius.circular(16)),
              child: Icon(Icons.event, color: cs.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(date, style: Theme.of(context).textTheme.bodyLarge),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
