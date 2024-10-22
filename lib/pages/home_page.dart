import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2196F3),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                  ),
                ),
                child: Column(
                  children: [
                    _buildExercisesHeader(),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        children: [
                          _buildExerciseCard(
                            'Music Therapy',
                            'Listen Calm Soul',
                            Icons.headphones,
                            Colors.purple,
                          ),
                          const SizedBox(height: 13),
                          _buildExerciseCard(
                            'Journaling',
                            'Start with Good Things',
                            Icons.book,
                            Colors.blue,
                          ),
                          const SizedBox(height: 13),
                          _buildExerciseCard(
                            'Daily Exercise',
                            '12 Exercises',
                            Icons.fitness_center,
                            Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hi, Harsh!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "18 Jan, 2024",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              _buildNotificationButton(),
            ],
          ),
          const SizedBox(height: 26),
          _buildSearchBar(),
          const SizedBox(height: 26),
          const Text(
            "How do you feel?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 17),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildEmojiButton('😢', 'Bad'),
              _buildEmojiButton('😊', 'Fine'),
              _buildEmojiButton('😄', 'Well'),
              _buildEmojiButton('😁', 'Excellent'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          print("Notification icon clicked");
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.notifications_none,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(17),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
          icon: const Icon(Icons.search, color: Colors.white, size: 20),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }

  Widget _buildEmojiButton(String emoji, String label) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(17),
            onTap: () {
              print("You clicked: $label");
            },
            splashColor: Colors.white.withOpacity(0.3),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 27),
              ),
            ),
          ),
        ),
        const SizedBox(height: 7),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildExercisesHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(17, 26, 17, 17),
      child: Column(
        children: [
          Container(
            height: 4,
            width: 34,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Exercises",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(String title, String subtitle, IconData icon, Color iconColor) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: () {
          print("Clicked on $title");
        },
        splashColor: iconColor.withOpacity(0.5), // Existing splash color
        highlightColor: iconColor.withOpacity(0.3), // Existing highlight color
        child: Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor, size: 26),
              ),
              const SizedBox(width: 17),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 3),
                    Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  ],
                ),
              ),
              // Arrow icon with increased ripple effect
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    // Same action as the card tap
                    print("Clicked on $title");
                  },
                  splashColor: Colors.grey.withOpacity(0.5), // Gray ripple effect
                  highlightColor: Colors.grey.withOpacity(0.3), // Highlight color
                  child: Container(
                    padding: const EdgeInsets.all(20), // Increased padding for ripple effect
                    child: Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400, size: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
