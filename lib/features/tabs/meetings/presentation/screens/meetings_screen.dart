import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/meetings/presentation/screens/meeting_confirmed_screen.dart';
import 'package:flutter/material.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({super.key});

  @override
  State<MeetingsScreen> createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  static const Color primary = Color(0xFF1197F7);
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kLight,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    _buildTab('Incoming', 0),
                    _buildTab('Outgoing', 1),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildMeetingCard(
                      name: 'Sarah Jenkins',
                      title: 'Quick project sync',
                      date: 'Oct 24',
                      duration: '30 min',
                      status: 'Pending',
                      statusColor: const Color(0xFFFF7043),
                      statusBg: const Color(0xFFFFF0EB),
                      avatarUrl: 'https://i.pravatar.cc/150?img=5',
                      isPending: true,
                    ),
                    const SizedBox(height: 16),
                    _buildMeetingCard(
                      name: 'Mark Thompson',
                      title: 'Design review',
                      date: 'Oct 25',
                      duration: '45 min',
                      status: 'Scheduled',
                      statusColor: const Color(0xFF2ECC71),
                      statusBg: const Color(0xFFE8FBF1),
                      avatarUrl: 'https://i.pravatar.cc/150?img=12',
                      isPending: false,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? primary : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMeetingCard({
    required String name,
    required String title,
    required String date,
    required String duration,
    required String status,
    required Color statusColor,
    required Color statusBg,
    required String avatarUrl,
    required bool isPending,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                  image: DecorationImage(
                    image: NetworkImage(avatarUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'with $name',
                      style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF3FB),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  date,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF555577),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 16,
                color: Colors.grey[500],
              ),
              const SizedBox(width: 6),
              Text(
                duration,
                style: TextStyle(fontSize: 13, color: Colors.grey[500]),
              ),
              const SizedBox(width: 10),
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    if (!isPending)
                      Icon(
                        Icons.check_circle_outline_rounded,
                        size: 14,
                        color: statusColor,
                      ),
                    if (!isPending) const SizedBox(width: 5),
                    if (isPending)
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.grey[100], thickness: 1),
          const SizedBox(height: 12),
          if (isPending)
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF3FB),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Text(
                        'Reschedule',
                        style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MeetingConfirmedScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(
                          'Accept',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            Container(
              width: double.infinity,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF3FB),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Center(
                child: Text(
                  'Join Meeting',
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
