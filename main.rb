require "ai-chat"
require "dotenv/load"
require "amazing_print"

chat = AI::Chat.new
chat.model = "gpt-5"
chat.reasoning_effort = "high"

chat.system("Your task is to look at a college course syllabus and extract all assignments, readings, exams, etc, from it, along with when they are due. The goal is to produce a list of assignments that will appear on a calendar, so that it's easy for the student to know exactly what needs to be done for each day across all their classes.")

chat.user("Please pull out everything I need to do for this class from this syllabus.", file: "00 - Syllabus - Organizational Analysis - Arroyo - W24 (1).pdf")

chat.schema = '{
  "name": "assignments",
  "schema": {
    "type": "object",
    "properties": {
      "assignments": {
        "type": "array",
        "description": "List of course assignments with due times/dates and descriptions.",
        "items": {
          "type": "object",
          "properties": {
            "due_at": {
              "type": "string",
              "description": "The due date/time for the assignment. Use ISO 8601 format. Include time if available, otherwise just the date (e.g., 2024-07-01 or 2024-07-01T23:59)."
            },
            "description": {
              "type": "string",
              "description": "Brief summary of the assignment with details like type, pages, chapters, etc."
            }
          },
          "required": [
            "due_at",
            "description"
          ],
          "additionalProperties": false
        }
      }
    },
    "required": [
      "assignments"
    ],
    "additionalProperties": false
  },
  "strict": true
}'

response = chat.generate!

text = response.fetch(:content)

ap text
