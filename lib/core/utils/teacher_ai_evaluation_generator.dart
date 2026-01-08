import 'package:edutech_app/core/models/ai_evaluation_model.dart';

class TeacherAIEvaluationGenerator {
  static AIEvaluation generateEvaluation({
    required int studentId,
    required String studentName,
    required int completedLessons,
    required int totalLessons,
  }) {
    final now = DateTime.now();
    final variationIndex = studentId % 3;

    // Teacher-focused evaluations with actionable insights for educators
    if (completedLessons >= 15) {
      // Exceptional performer - Master level
      return AIEvaluation(
        summary:
            '$studentName demonstrates exceptional mastery with $completedLessons lessons completed. This student shows advanced comprehension and is ready for enrichment activities. Consider assigning leadership roles, advanced projects, or peer tutoring opportunities to further develop their potential.',
        strengths: [
          'Exceeds expectations in all subjects',
          'Advanced problem-solving skills',
          'Strong leadership abilities',
          'Self-directed learner',
          'Excellent concept retention',
        ],
        areasForImprovement: [
          'Needs more challenging assignments',
          'Could explore interdisciplinary projects',
        ],
        recommendations: [
          'Assign peer tutoring or mentorship roles to help other students',
          'Provide advanced research projects or independent study options',
          'Encourage participation in academic competitions or challenges',
          'Consider acceleration to more advanced curriculum if appropriate',
          'Create opportunities for student to teach concepts to the class',
        ],
        generatedAt: now,
      );
    } else if (completedLessons >= 10) {
      // Advanced performer - Expert level
      return AIEvaluation(
        summary:
            '$studentName is performing at an advanced level with $completedLessons completed lessons. This student consistently demonstrates strong understanding and is progressing well above grade level. They would benefit from differentiated instruction that challenges their abilities while maintaining engagement.',
        strengths: [
          'Strong grasp of core concepts',
          'Excellent work habits',
          'High motivation and engagement',
          'Good analytical skills',
          'Effective learning strategies',
        ],
        areasForImprovement: [
          'Needs more complex problem solving',
          'Could explore topics in greater depth',
        ],
        recommendations: [
          'Provide enrichment activities that extend beyond standard curriculum',
          'Introduce project-based learning opportunities',
          'Encourage peer collaboration on challenging assignments',
          'Offer choice in assignments to maintain high engagement',
          'Consider small group instruction with other advanced learners',
        ],
        generatedAt: now,
      );
    } else if (completedLessons >= 5) {
      // High performer - Proficient level
      return AIEvaluation(
        summary:
            '$studentName is performing at a proficient level with $completedLessons lessons completed. This student demonstrates solid understanding of core concepts and is meeting grade-level expectations. Continue providing structured support while gradually increasing independence.',
        strengths: [
          'Meets grade-level expectations',
          'Good understanding of fundamentals',
          'Positive learning attitude',
          'Completes assignments on time',
          'Shows improvement with practice',
        ],
        areasForImprovement: [
          'Needs more practice applying concepts',
          'Could connect ideas across subjects',
          'Needs more independent problem-solving',
        ],
        recommendations: [
          'Continue providing clear structure and expectations',
          'Use formative assessments to identify specific areas for growth',
          'Provide opportunities for peer learning and collaboration',
          'Encourage self-reflection on learning strategies',
          'Offer additional practice materials for areas needing reinforcement',
        ],
        generatedAt: now,
      );
    } else if (completedLessons >= 3) {
      // Moderate performer - Developing level
      return AIEvaluation(
        summary:
            '$studentName is in the developing phase with $completedLessons lessons completed. This student is building foundational skills and may need additional support to reach proficiency. Focus on building confidence while providing targeted interventions in areas of difficulty.',
        strengths: [
          'Shows effort and persistence',
          'Responds well to encouragement',
          'Building foundational knowledge',
          'Willing to ask questions',
          'Shows growth with practice',
        ],
        areasForImprovement: [
          'Needs support in core subjects',
          'Could use more structured activities',
          'Needs stronger study habits',
          'Could improve time management',
        ],
        recommendations: [
          'Provide small group instruction or one-on-one support',
          'Break down complex tasks into smaller, manageable steps',
          'Use visual aids and hands-on activities to reinforce concepts',
          'Implement frequent check-ins to monitor progress',
          'Provide immediate feedback and celebrate small successes',
          'Consider differentiated instruction to meet learning needs',
        ],
        generatedAt: now,
      );
    } else if (completedLessons >= 1) {
      // Beginner - Emerging level with variations
      if (variationIndex == 0) {
        return AIEvaluation(
          summary:
              '$studentName is an enthusiastic emerging learner with $completedLessons lesson${completedLessons == 1 ? '' : 's'} completed. This student shows high engagement and eagerness to learn, which is a strong foundation. Channel this enthusiasm into structured learning activities to maximize their potential.',
          strengths: [
            'High enthusiasm for learning',
            'Quick to engage with new content',
            'Genuine interest in understanding',
            'Eager to participate in discussions',
          ],
          areasForImprovement: [
            'Needs structure for enthusiasm',
            'Could focus on one task at a time',
            'Needs help with sustained attention',
            'Could follow multi-step instructions better',
          ],
          recommendations: [
            'Use interactive, hands-on activities to maintain engagement',
            'Break lessons into shorter segments with clear transitions',
            'Provide immediate positive feedback for effort and participation',
            'Create structured learning games that reinforce key concepts',
            'Set clear expectations and use visual schedules',
            'Pair with a peer mentor for additional support',
          ],
          generatedAt: now,
        );
      } else if (variationIndex == 1) {
        return AIEvaluation(
          summary:
              '$studentName is a thoughtful emerging learner with $completedLessons lesson${completedLessons == 1 ? '' : 's'} completed. This student approaches learning with careful consideration, which shows maturity. Support their reflective nature while encouraging them to take learning risks in a safe environment.',
          strengths: [
            'Thoughtful learning approach',
            'Takes time to understand concepts',
            'Asks insightful questions',
            'Builds solid foundation',
          ],
          areasForImprovement: [
            'Could take more calculated risks',
            'Needs balance between thoroughness and progress',
            'Could build more confidence',
            'Needs to avoid perfectionism',
          ],
          recommendations: [
            'Encourage "good enough" understanding before moving forward',
            'Set reasonable time limits to maintain learning momentum',
            'Use think-pair-share activities to build confidence',
            'Celebrate progress and effort, not just perfection',
            'Provide low-stakes practice opportunities',
            'Help them understand that mistakes are valuable learning opportunities',
          ],
          generatedAt: now,
        );
      } else {
        return AIEvaluation(
          summary:
              '$studentName is a cautious emerging learner with $completedLessons lesson${completedLessons == 1 ? '' : 's'} completed. This student takes careful, measured steps in their learning journey. Provide a supportive, low-pressure environment to help them build confidence and take learning risks.',
          strengths: [
            'Careful learning approach',
            'Strong attention to detail',
            'Willing to ask for help',
            'Builds confidence step by step',
          ],
          areasForImprovement: [
            'Needs encouragement to try new things',
            'Could see mistakes as learning opportunities',
            'Needs help building confidence',
            'Could take more learning risks',
          ],
          recommendations: [
            'Create a "safe to fail" learning environment',
            'Start with very easy challenges to build confidence',
            'Use lots of positive reinforcement and specific praise',
            'Break learning into tiny, manageable steps',
            'Celebrate effort and attempts, not just success',
            'Pair with a supportive peer or learning buddy',
            'Model making mistakes and learning from them',
          ],
          generatedAt: now,
        );
      }
    } else {
      // Just starting - Pre-learning level with 3 randomized variations
      // Use a combination of studentId and current time for more randomization
      final randomSeed = (studentId + now.millisecondsSinceEpoch) % 3;

      if (randomSeed == 0) {
        // Variation 1: Enthusiastic Starter
        return AIEvaluation(
          summary:
              '$studentName is ready to begin their learning journey with enthusiasm! This student shows eagerness and readiness to learn. Make the first lessons memorable and engaging to set a positive tone for their entire educational experience.',
          strengths: [
            'Eager to learn',
            'No negative experiences',
            'Fresh perspective',
            'Natural curiosity',
          ],
          areasForImprovement: [
            'Needs clear learning expectations',
            'Requires platform understanding',
            'Could see learning examples',
            'Needs help managing excitement',
          ],
          recommendations: [
            'Make the first lesson a special, memorable experience',
            'Take time to orient student to learning platform and tools',
            'Set up clear routines and expectations from the start',
            'Start with highly engaging, interactive lessons',
            'Connect learning to student\'s personal interests',
            'Provide lots of encouragement and celebrate first successes',
            'Create a positive learning environment from day one',
          ],
          generatedAt: now,
        );
      } else if (randomSeed == 1) {
        // Variation 2: Thoughtful Preparer
        return AIEvaluation(
          summary:
              '$studentName is preparing to begin their learning journey with a thoughtful approach. This student wants to understand expectations before starting, which shows maturity. Provide clear guidance and support to help them feel comfortable and confident.',
          strengths: [
            'Thoughtful approach to new experiences',
            'Wants to understand before starting',
            'Willing to prepare properly',
            'Clean slate for optimal start',
          ],
          areasForImprovement: [
            'Needs clear learning explanation',
            'Could see learning process examples',
            'Needs reassurance about expectations',
            'Requires help understanding structure',
          ],
          recommendations: [
            'Provide a clear overview of the learning journey ahead',
            'Show examples of completed work from other students',
            'Explain the learning process step-by-step',
            'Answer all questions before starting the first lesson',
            'Create a comfortable, predictable learning environment',
            'Set clear expectations about time, effort, and participation',
            'Start with a simple, well-explained first lesson',
          ],
          generatedAt: now,
        );
      } else {
        // Variation 3: Gentle Beginner
        return AIEvaluation(
          summary:
              '$studentName is preparing to begin their learning journey and may need a gentle, supportive introduction. Every learner starts at their own pace. With patience, encouragement, and the right approach, this student will discover that learning can be enjoyable and rewarding.',
          strengths: [
            'Willing to try with support',
            'No negative experiences',
            'Opportunity for positive start',
            'Can learn at own pace',
          ],
          areasForImprovement: [
            'Needs extra encouragement',
            'Could use gentle introduction',
            'Needs help overcoming hesitation',
            'Needs to understand learning is safe',
          ],
          recommendations: [
            'Start with very short, low-pressure learning activities',
            'Use lots of encouragement and positive reinforcement',
            'Make the first experience fun and non-threatening',
            'Let student observe before participating if needed',
            'Create a calm, supportive learning environment',
            'Celebrate even the smallest steps forward',
            'Be patient and let student set their own pace initially',
            'Connect learning to things student already enjoys',
          ],
          generatedAt: now,
        );
      }
    }
  }
}
