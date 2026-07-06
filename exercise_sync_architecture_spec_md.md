# Exercise Sync Architecture Specification

## Goal

Implement Exercise module architecture:

```text
External Exercise API
        ↓
NestJS Sync Worker
        ↓
PostgreSQL Exercise table
        ↓
Flutter search local DB
```

The mobile app MUST NOT call external APIs directly.
All exercise data should be synced into local PostgreSQL database first.
Flutter only communicates with backend APIs.

---

# Current Database

Current database already contains:

## Exercise table

```sql
Exercise
- Id
- Name
- Type
- Met
- DefaultCalPerMin
- Notes
- CreatedAt
- UpdatedAt
- DelFlag
```

## ExerciseLog table

```sql
ExerciseLog
- Id
- UserId
- ExerciseId
- StartedAt
- MinutesPerformed
- CaloriesBurned
- Source
- CapturedAt
- CreatedAt
- UpdatedAt
- DelFlag
```

Use existing tables.
Do not recreate them.

---

# External API

Use:

```text
API Ninjas Exercise API
```

Documentation:

https://api-ninjas.com/api/exercises

Example:

```http
GET https://api.api-ninjas.com/v1/exercises?muscle=chest
```

API Key should be stored in environment variables.

---

# Backend Tasks

# 1. Install Dependencies

```bash
npm install axios @nestjs/axios @nestjs/schedule
```

---

# 2. Environment Variables

Add:

```env
API_NINJAS_KEY=your_api_key
API_NINJAS_EXERCISE_URL=https://api.api-ninjas.com/v1/exercises
```

---

# 3. Create Exercise Sync Module

Create:

```text
src/modules/exercises-sync
```

Structure:

```text
exercises-sync/
 ├── exercise-sync.module.ts
 ├── exercise-sync.service.ts
 ├── exercise-sync.controller.ts
```

---

# 4. Exercise Sync Service

Responsibilities:

- Call external exercise API
- Fetch exercise data by muscle groups
- Map external response into local Exercise entity
- Upsert into PostgreSQL
- Avoid duplicate exercises

---

# 5. Supported Muscle Groups

Use:

```ts
[
  'abdominals',
  'biceps',
  'chest',
  'forearms',
  'glutes',
  'hamstrings',
  'lats',
  'lower_back',
  'quadriceps',
  'triceps',
]
```

---

# 6. Mapping Rules

Map external API response into local DB.

## External Response Example

```json
{
  "name": "barbell bench press",
  "type": "strength",
  "muscle": "chest",
  "equipment": "barbell",
  "difficulty": "intermediate",
  "instructions": "Lie flat on bench..."
}
```

---

## Mapping

| External Field | Local Field |
|---|---|
| name | Exercise.Name |
| type | Exercise.Type |
| instructions | Exercise.Notes |

---

# 7. Exercise Type Mapping

Map:

```text
cardio -> cardio
all other types -> strength
```

Because database enum currently supports:

```text
cardio
strength
```

---

# 8. Upsert Logic

Use upsert based on Exercise.Name.

Do not insert duplicate exercises.

Pseudo:

```ts
upsert by Name
```

---

# 9. Create Manual Sync API

Create endpoint:

```http
POST /admin/exercises/sync
```

Responsibilities:

- Trigger exercise synchronization manually
- Return sync summary

Example response:

```json
{
  "message": "Sync exercises successfully"
}
```

---

# 10. Create Search Exercise API

Create endpoint:

```http
GET /exercises
```

Supported query params:

```text
q
type
limit
page
```

Example:

```http
GET /exercises?q=bench&type=strength
```

---

# 11. Search Requirements

Search should:

- Search by exercise name
- Filter by exercise type
- Ignore deleted records
- Sort by name ascending
- Support pagination

Use PostgreSQL LIKE or ILIKE search.

---

# 12. Exercise Search Response

Example:

```json
[
  {
    "id": 1,
    "name": "Barbell Bench Press",
    "type": "strength",
    "met": 6.5,
    "notes": "Lie flat on bench..."
  }
]
```

---

# 13. Flutter Responsibilities

Flutter MUST:

- Call backend APIs only
- NEVER call external API directly
- Implement search UI
- Implement exercise detail screen
- Implement add exercise log flow

---

# 14. Flutter Search Flow

```text
User types keyword
→ Flutter calls GET /exercises
→ Backend searches PostgreSQL
→ Flutter renders exercise list
```

---

# 15. Exercise Log Flow

```text
User selects exercise
→ Input duration
→ POST /exercise-logs
→ Backend calculates calories burned
→ Save ExerciseLog
→ Return created log
```

---

# 16. Calories Burned Formula

Use:

```text
CaloriesBurned = MET × weightKg × durationHours
```

Example:

```text
MET = 8
Weight = 65kg
Duration = 0.5h

CaloriesBurned = 260 kcal
```

---

# 17. Create Exercise Log API

Endpoint:

```http
POST /exercise-logs
```

Request:

```json
{
  "exerciseId": 1,
  "minutesPerformed": 30,
  "startedAt": "2026-05-12T20:00:00Z"
}
```

Backend should:

- Get Exercise by ID
- Get current user weight
- Calculate calories burned
- Save ExerciseLog

---

# 18. Optional Improvements

Optional future improvements:

## Add columns to Exercise

Potential future columns:

```text
MuscleGroup
Equipment
Difficulty
ImageUrl
SourceApi
```

---

# 19. Future AI Coach Integration

Future AI features:

```text
- Recommend low impact exercises
- Recommend cardio for diabetes users
- Filter exercises by fitness level
- Personalized workout suggestions
```

---

# 20. Recommended Implementation Order

Implement in this order:

```text
1. Exercise entity/repository
2. GET /exercises
3. Exercise sync service
4. POST /admin/exercises/sync
5. Sync external data
6. Flutter exercise search UI
7. POST /exercise-logs
8. Calories calculation
9. Exercise history screen
```

---

# Expected Result

Final architecture:

```text
External Exercise API
        ↓
NestJS Sync Worker
        ↓
PostgreSQL Exercise table
        ↓
Flutter search local DB
```

Benefits:

- Faster search
- No API key exposure
- Stable mobile app
- Local caching
- Easier AI integration later
- Better HealthTech architecture

