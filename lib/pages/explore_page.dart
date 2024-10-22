import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const SliverAppBar(
                    backgroundColor: Colors.white,
                    floating: true,
                    pinned: false,
                    expandedHeight: 80,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(left: 16, bottom: 8), // Reduced bottom padding
                      title: Text(
                        'Explore',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 24),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.72,
                      children: [
                        _buildExploreItem(Icons.music_note, 'Music Therapy', 'Explore the benefits of music for mental health', Colors.blue[200]!, Colors.blue),
                        _buildExploreItem(Icons.brush, 'Art Therapy', 'Use art as a way to express and process feelings', Colors.orange[200]!, Colors.deepOrange),
                        _buildExploreItem(Icons.book, 'Journal', 'Write your thoughts to gain clarity and insight', Colors.green[200]!, Colors.green),
                        _buildExploreItem(Icons.bolt, 'Breathing Techniques', 'Learn techniques to manage stress and anxiety', Colors.lightBlue[200]!, Colors.lightBlue),
                        _buildExploreItem(Icons.sentiment_satisfied, 'Mood Tracker', 'Track your mood to identify patterns and triggers', Colors.yellow[200]!, Colors.amber),
                        _buildExploreItem(Icons.warning, 'SOS Tips', 'Quick tips for managing anxiety and stress', Colors.teal[200]!, Colors.teal),
                        _buildExploreItem(Icons.support_agent, 'Support Groups', 'Connect with others who share similar experiences', Colors.red[200]!, Colors.red),
                        _buildExploreItem(Icons.emoji_people, 'Mindfulness', 'Practice mindfulness techniques for better focus', Colors.purple[200]!, Colors.purple),
                        _buildExploreItem(Icons.lightbulb, 'Positive Affirmations', 'Learn to cultivate positivity through affirmations', Colors.cyan[200]!, Colors.cyan),
                        _buildExploreItem(Icons.accessibility_new, 'Physical Activity', 'Discover the benefits of exercise on mental health', Colors.indigo[200]!, Colors.indigo),
                      ],
                    ),
                  ),
                  // Add extra space at the bottom
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 40),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExploreItem(IconData icon, String title, String subtitle, Color bgColor, Color iconColor) {
    return InkWell(
      onTap: () {
        // Handle tap action, e.g., navigate to a new page
      },
      borderRadius: BorderRadius.circular(16), // Ensure the ripple effect respects the container's shape
      child: Container(
        width: 140,
        height: 170,
        decoration: BoxDecoration(
          color: bgColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: iconColor),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
