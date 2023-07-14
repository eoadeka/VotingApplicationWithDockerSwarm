from django.test import TestCase
from .models import Question, Choice

# Create your tests here.
class QuestionTestCase(TestCase):
    def testQuestion(self):
        question = Question(question_text='What is your name?', pub_date='14/07/2023')
        self.assertEqual(question.question_text, 'What is your name?')
        self.assertEqual(question.pub_date, '14/07/2023')