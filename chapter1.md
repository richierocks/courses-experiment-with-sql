---
title       : sqlwhat examples (intro to SQL)
description : Examples of the intro to SQL for Data Science course
---

## Example 1

```yaml
type: NormalExercise
xp: 100
```

`@instructions`
Select the `title` column from the `films` table.

`@pre_exercise_code`
```{python}
connect('postgresql', 'films')
```

`@solution`
```{sql}
SELECT title
FROM films;
```

`@sct`
```{python}
Ex().check_correct(
    check_col('title').is_equal(),
    check_node('SelectStmt').multi(
        check_field('target_list', 0).has_equal_ast(),
        check_field('from_clause').has_equal_ast()
    )
)
Ex().success_msg("You are awesome!")
```

