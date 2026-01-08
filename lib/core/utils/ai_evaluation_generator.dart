import 'package:edutech_app/core/models/ai_evaluation_model.dart';

class AIEvaluationGenerator {
  static AIEvaluation generateEvaluation({
    required int studentId,
    required String studentName,
    required int completedLessons,
    required int totalLessons,
  }) {
    final now = DateTime.now();
    final variationIndex = studentId % 3;

    // Completely unique evaluations for each progress level
    if (completedLessons >= 15) {
      // Exceptional performer - Master level
      return AIEvaluation(
        summary:
            '$studentName has achieved mastery-level performance with $completedLessons lessons completed! This exceptional achievement reflects not just quantity, but quality of learning. They\'ve transformed from a student into a true scholar, demonstrating deep understanding and the ability to connect complex ideas across different domains.',
        strengths: [
          'Master-level comprehension with ability to teach others',
          'Exceptional pattern recognition and concept synthesis',
          'Intrinsic motivation that drives independent exploration',
          'Advanced metacognitive skills - knows how they learn best',
          'Leadership qualities in collaborative learning environments',
        ],
        areasForImprovement: [
          'Could develop research and inquiry-based projects',
          'May benefit from creating original content or solutions',
        ],
        recommendations: [
          'Assign mentorship roles to help other students',
          'Design independent research projects on topics of interest',
          'Encourage participation in academic competitions or challenges',
          'Explore real-world applications through internships or projects',
        ],
        generatedAt: now,
      );
    } else if (completedLessons >= 10) {
      // Advanced performer - Expert level
      return AIEvaluation(
        summary:
            '$studentName has reached expert status with $completedLessons completed lessons! Their learning trajectory shows remarkable acceleration - they\'re not just keeping pace, they\'re setting the pace. The depth of their understanding is evident in how they approach new challenges with strategic thinking and creative problem-solving.',
        strengths: [
          'Rapid knowledge acquisition with high retention rates',
          'Strategic approach to learning - knows what to focus on',
          'Excellent pattern recognition across different subjects',
          'Strong self-regulation and independent study skills',
          'Ability to transfer knowledge between different contexts',
        ],
        areasForImprovement: [
          'Could develop deeper expertise in specific areas of interest',
          'May benefit from exploring cutting-edge or advanced topics',
        ],
        recommendations: [
          'Introduce specialized courses in areas of demonstrated interest',
          'Encourage participation in advanced problem-solving challenges',
          'Connect learning to real-world applications and case studies',
          'Foster collaboration with peers on complex projects',
        ],
        generatedAt: now,
      );
    } else if (completedLessons >= 5) {
      // High performer - Proficient level
      return AIEvaluation(
        summary:
            '$studentName has reached proficiency with $completedLessons lessons completed! They\'ve moved beyond basic understanding to demonstrate genuine competence. Their learning shows clear progression - each lesson builds meaningfully on the last, creating a solid knowledge framework that they can confidently navigate.',
        strengths: [
          'Strong foundational knowledge across multiple subjects',
          'Consistent effort that translates to measurable progress',
          'Good grasp of fundamental concepts and principles',
          'Developing critical thinking and analytical skills',
          'Positive learning mindset with resilience to challenges',
        ],
        areasForImprovement: [
          'Could work on applying knowledge in novel situations',
          'May benefit from more complex, multi-step problem solving',
          'Consider exploring connections between different subject areas',
        ],
        recommendations: [
          'Introduce projects that require applying multiple concepts together',
          'Encourage exploration of how different subjects relate to each other',
          'Set challenges that require creative thinking, not just recall',
          'Provide opportunities to explain concepts to others',
        ],
        generatedAt: now,
      );
    } else if (completedLessons >= 3) {
      // Moderate performer - Developing level
      return AIEvaluation(
        summary:
            '$studentName is in the developing phase with $completedLessons lessons completed. They\'re building momentum and establishing their learning identity. While still finding their footing, they show promising signs of growth - each completed lesson represents a small victory that\'s building their confidence and competence.',
        strengths: [
          'Growing confidence with each completed lesson',
          'Willingness to persist through learning challenges',
          'Building a personal learning rhythm and style',
          'Showing curiosity and asking questions',
          'Developing basic study skills and habits',
        ],
        areasForImprovement: [
          'Needs more structured practice to reinforce learning',
          'Could benefit from breaking down complex topics into smaller parts',
          'May need help connecting new information to what they already know',
          'Could work on time management for learning activities',
        ],
        recommendations: [
          'Create a weekly learning schedule with specific time blocks',
          'Use visual aids and summaries to reinforce key concepts',
          'Practice active recall through regular review sessions',
          'Set small, daily goals that build up to weekly achievements',
          'Provide immediate feedback to reinforce correct understanding',
        ],
        generatedAt: now,
      );
    } else if (completedLessons >= 1) {
      // Beginner - Emerging level with variations
      if (variationIndex == 0) {
        return AIEvaluation(
          summary:
              '$studentName is an enthusiastic emerging learner with $completedLessons lesson${completedLessons == 1 ? '' : 's'} completed! Their excitement about learning is palpable - they approach each lesson with genuine interest and eagerness. This positive energy is a powerful foundation that, when channeled correctly, can accelerate their learning journey significantly.',
          strengths: [
            'High enthusiasm and positive attitude toward learning',
            'Quick to engage with new content and concepts',
            'Shows genuine interest in understanding how things work',
            'Eager to share what they\'ve learned with others',
          ],
          areasForImprovement: [
            'Needs structure to channel enthusiasm productively',
            'Could benefit from learning to pace themselves',
            'May need help focusing enthusiasm on key concepts',
            'Could work on sustaining interest through longer sessions',
          ],
          recommendations: [
            'Channel their excitement into structured learning games',
            'Create a "learning journal" where they can document discoveries',
            'Set up short, high-energy learning bursts (15-20 min)',
            'Use their enthusiasm to teach concepts back to you',
            'Connect learning to their personal interests and hobbies',
            'Celebrate their natural curiosity with special learning rewards',
          ],
          generatedAt: now,
        );
      } else if (variationIndex == 1) {
        return AIEvaluation(
          summary:
              '$studentName is a thoughtful emerging learner with $completedLessons lesson${completedLessons == 1 ? '' : 's'} completed. They approach learning with careful consideration, taking time to truly understand before moving forward. This methodical approach, while slower, builds deep understanding and creates a solid foundation for future learning.',
          strengths: [
            'Thoughtful and reflective approach to learning',
            'Takes time to fully understand concepts before moving on',
            'Asks insightful questions that show deep thinking',
            'Builds strong foundational understanding',
          ],
          areasForImprovement: [
            'Could benefit from encouragement to take learning risks',
            'May need help balancing thoroughness with progress',
            'Could work on building confidence in their understanding',
            'Needs support to avoid perfectionism that slows progress',
          ],
          recommendations: [
            'Encourage "good enough" understanding before moving forward',
            'Set time limits for each lesson to maintain momentum',
            'Use "think-pair-share" activities to build confidence',
            'Celebrate progress, not just perfection',
            'Introduce low-stakes practice before formal assessments',
            'Help them see that mistakes are part of learning',
          ],
          generatedAt: now,
        );
      } else {
        return AIEvaluation(
          summary:
              '$studentName is a cautious emerging learner with $completedLessons lesson${completedLessons == 1 ? '' : 's'} completed. They\'re taking careful, measured steps in their learning journey, which shows wisdom beyond their experience. While they may need extra encouragement, their careful approach means they truly understand each step before taking the next.',
          strengths: [
            'Careful and deliberate learning approach',
            'Strong attention to detail and accuracy',
            'Willingness to ask for help when needed',
            'Builds confidence through mastery of each step',
          ],
          areasForImprovement: [
            'Needs encouragement to try new things without fear',
            'Could benefit from seeing that mistakes are learning opportunities',
            'May need help building confidence in their abilities',
            'Could work on taking learning risks in a safe environment',
          ],
          recommendations: [
            'Create a "safe to fail" learning environment',
            'Start with very easy challenges to build confidence',
            'Use lots of positive reinforcement and encouragement',
            'Break learning into tiny, manageable steps',
            'Celebrate effort and attempts, not just success',
            'Pair them with a learning buddy for support',
            'Show examples of others learning from mistakes',
          ],
          generatedAt: now,
        );
      }
    } else {
      // Just starting - Pre-learning level with variations
      if (variationIndex == 0) {
        return AIEvaluation(
          summary:
              '$studentName is at the starting line, eyes bright with anticipation! They\'re ready and eager to begin their learning adventure. This enthusiasm is a precious resource - when properly nurtured, it becomes the fuel that powers their entire educational journey. The first lesson will be magical, setting the tone for everything that follows.',
          strengths: [
            'Eager anticipation and readiness to learn',
            'No previous negative experiences to overcome',
            'Fresh perspective with unlimited potential',
            'Natural curiosity waiting to be awakened',
          ],
          areasForImprovement: [
            'Needs clear introduction to learning expectations',
            'Requires understanding of the learning platform',
            'Could benefit from seeing the learning journey ahead',
            'May need help managing excitement with realistic pacing',
          ],
          recommendations: [
            'Make the first lesson a special, memorable experience',
            'Take a fun tour of the learning platform together',
            'Set up a dedicated learning space they\'ll love',
            'Create excitement with a "learning adventure" theme',
            'Start with the most engaging, interactive lesson',
            'Take photos or videos of their first learning moments',
            'Connect learning to their favorite activities or interests',
          ],
          generatedAt: now,
        );
      } else if (variationIndex == 1) {
        return AIEvaluation(
          summary:
              '$studentName stands at the threshold of learning, taking a moment to observe and understand before beginning. This thoughtful approach shows maturity - they want to know what to expect and how things work. Once they feel comfortable and prepared, they\'ll step forward with confidence and purpose.',
          strengths: [
            'Thoughtful and observant approach to new experiences',
            'Desire to understand before beginning',
            'No rush - willing to take time to prepare properly',
            'Clean slate with opportunity for optimal start',
          ],
          areasForImprovement: [
            'Needs clear explanation of what learning involves',
            'Could benefit from seeing examples of the learning process',
            'May need reassurance about what to expect',
            'Requires help understanding the learning structure',
          ],
          recommendations: [
            'Provide a clear overview of the learning journey',
            'Show examples of completed lessons from other students',
            'Explain the learning process step-by-step',
            'Answer all their questions before starting',
            'Create a comfortable, predictable learning environment',
            'Set clear expectations about time and effort required',
            'Start with a simple, well-explained first lesson',
          ],
          generatedAt: now,
        );
      } else {
        return AIEvaluation(
          summary:
              '$studentName is preparing to begin their learning journey, and they may need a gentle, supportive introduction. Every learner starts at their own pace, and taking time to feel comfortable is perfectly normal. With patience, encouragement, and the right approach, they\'ll discover that learning can be enjoyable and rewarding.',
          strengths: [
            'Willingness to try new things with support',
            'No pressure from previous learning experiences',
            'Opportunity to build positive first impressions',
            'Can develop learning habits at their own pace',
          ],
          areasForImprovement: [
            'Needs extra encouragement and reassurance',
            'Could benefit from a very gentle introduction',
            'May need help overcoming initial hesitation',
            'Requires understanding that learning is safe and fun',
          ],
          recommendations: [
            'Start with very short, low-pressure learning activities',
            'Use lots of encouragement and positive reinforcement',
            'Make the first experience fun and non-threatening',
            'Let them observe before participating if needed',
            'Create a calm, supportive learning environment',
            'Celebrate even the smallest steps forward',
            'Be patient and let them set their own pace',
            'Connect learning to things they already enjoy',
          ],
          generatedAt: now,
        );
      }
    }
  }
}

