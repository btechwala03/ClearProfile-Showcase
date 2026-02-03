import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme.dart';
import '../components/buttons.dart';
import '../components/input_field.dart';
import '../components/platform_selector.dart';
import '../components/trivia_card.dart';
import '../components/responsive_wrapper.dart';
import '../components/glass_card.dart';
import '../components/animated_bg.dart';
import '../api_service.dart'; // WIRED: Import Backend Service
import 'dart:async';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _selectedPlatformIndex = -1;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Trivia Carousel State
  final PageController _pageController = PageController();
  int _currentTriviaIndex = 0;
  Timer? _animTimer;
  
  final List<Map<String, String>> _triviaData = [
     {
      'title': 'Digital Footprint', 
      'content': '70% of employers screen candidates on social media.',
      'icon': 'public'
    },
    {
      'title': 'Data Privacy', 
      'content': 'Deleted posts can still be archived by third parties.',
       'icon': 'security'
    },
    {
      'title': 'Travel Safety', 
      'content': 'Border control may request access to your devices.',
       'icon': 'flight'
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTriviaTimer();
  }

  @override
  void dispose() {
    _animTimer?.cancel();
    _pageController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _startTriviaTimer() {
    _animTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        int nextPage = _currentTriviaIndex + 1;
        if (nextPage >= _triviaData.length) {
          nextPage = 0;
           _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
          );
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
          );
        }
      }
    });
  }

    final List<Map<String, dynamic>> _platforms = [
    {'icon': FontAwesomeIcons.instagram, 'name': 'Instagram'},
    {'icon': FontAwesomeIcons.xTwitter, 'name': 'X'},
    {'icon': FontAwesomeIcons.youtube, 'name': 'YouTube'},
  ];


  void _analyzeProfile() {
    if (_usernameController.text.isNotEmpty) {
      // WIRED: Backend Integration Logic
      if (_passwordController.text.isNotEmpty && _selectedPlatformIndex != 2) {
          // Login Flow
          ApiService.loginStart(_usernameController.text, _passwordController.text);
      } else {
          // Public Scan Flow
           ApiService.ingestInstagram(_usernameController.text);
      }

      context.push('/scan');
    } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter a username to analyze')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // 0. Background Source for Liquid Glass
          const Positioned.fill(child: AnimatedTechBackground()),

          ResponsiveWrapper(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                // Main Content Section
                Padding(
                  padding: AppSpacing.paddingLg,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 24),
                      Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/logo.png', // Reverted to Original Internal Logo
                              height: 180,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ).animate()
                        .fadeIn(duration: 800.ms)
                        .slideY(begin: -1.5, end: 0, duration: 1200.ms, curve: Curves.easeOutCubic),
                  
                      const SizedBox(height: 48),
                  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_platforms.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: PlatformSelectorChip(
                              icon: _platforms[index]['icon'] as IconData,
                              isSelected: _selectedPlatformIndex == index,
                              onTap: () => setState(() => _selectedPlatformIndex = index),
                            ),
                          );
                        }),
                      ).animate().fadeIn(delay: 100.ms).scale(),
                  
                      const SizedBox(height: 32),
                  
                      // GLASS CARD WRAPPER FOR INPUTS
                      GlassCard(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                             InputField(
                              hintText: 'Username',
                              controller: _usernameController,
                            ),
                        
                            // Password Field (Hidden for YouTube)
                            AnimatedSize(
                              duration: 300.ms,
                              curve: Curves.easeInOut,
                              child: _selectedPlatformIndex != 2 // 2 is YouTube
                                  ? Column(
                                      children: [
                                        const SizedBox(height: 16),
                                        InputField(
                                          hintText: 'Password (Optional)',
                                          isPassword: true,
                                          controller: _passwordController,
                                          suffixIcon: Icons.fingerprint,
                                          animateSuffix: true,
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                            ),
                        
                            const SizedBox(height: 32),
                        
                            PrimaryButton(
                              label: 'Analyze Profile',
                              onTap: _analyzeProfile,
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 200.ms).moveY(begin: 20, end: 0),
                    ],
                  ),
                ),
            
                const SizedBox(height: 48),
            
                // Trivia Section (Now part of the scroll)
                GlassCard(
                  padding: EdgeInsets.zero,
                  child: InkWell(
                    onTap: () => context.push('/trivia'),
                    child: SizedBox( // Changed from Container to SizedBox as GlassCard handles decoration
                      height: 160,
                      width: double.infinity,
                      // removed decoration as GlassCard provides it
                      child: Stack(
                        children: [
                          Positioned(
                            top: 12,
                            left: 24,
                            child: Text(
                              'DID YOU KNOW?', // Renamed for catchiness in flow
                              style: context.textStyles.labelSmall?.bold.withColor(AppColors.accent),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 24,
                            child: Icon(Icons.arrow_forward, size: 16, color: AppColors.accent),
                          ),
                          
                          Column(
                            children: [
                              Expanded(
                                child: PageView.builder(
                                  controller: _pageController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _triviaData.length,
                                  itemBuilder: (context, index) {
                                    final data = _triviaData[index];
                                    IconData icon;
                                    switch(data['icon']) {
                                      case 'public': icon = Icons.public; break;
                                      case 'security': icon = Icons.security; break;
                                      default: icon = Icons.flight;
                                    }
                                    
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(icon, color: AppColors.accent, size: 28),
                                            const SizedBox(height: 8),
                                            Text(
                                              data['title']!,
                                              style: context.textStyles.labelLarge?.bold.withColor(AppColors.onSurface),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              data['content']!,
                                              textAlign: TextAlign.center,
                                              style: context.textStyles.bodyMedium?.withColor(AppColors.onSurfaceVariant),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(_triviaData.length, (index) {
                                     return AnimatedContainer(
                                       duration: const Duration(milliseconds: 300),
                                       margin: const EdgeInsets.symmetric(horizontal: 4),
                                       height: 6,
                                       width: _currentTriviaIndex == index ? 16 : 6,
                                       decoration: BoxDecoration(
                                         color: _currentTriviaIndex == index ? AppColors.accent : AppColors.onSurfaceVariant.withOpacity(0.3),
                                         borderRadius: BorderRadius.circular(3),
                                       ),
                                     );
                                  }),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 500.ms).moveY(begin: 50, end: 0),
              ],
            ),
          ),
        ),
      ), // Closing parenthesis for ResponsiveWrapper
      ]),
    );
  }
}
