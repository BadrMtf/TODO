#!/bin/bash

TODO_FILE="todo.txt"

# Ensure the todo file exists
touch "$TODO_FILE"

# Function to display usage
usage() {
  echo "Usage: $0 [create|update|delete|show|list|search]" >&2
  exit 1
}

# Function to create a task
create_task() {
  read -p "Title: " title
  if [ -z "$title" ]; then
    echo "Title is required" >&2
    exit 1
  fi

  read -p "Due date (YYYY-MM-DD): " due_date
  if ! date -d "$due_date" &>/dev/null; then
    echo "Invalid date format" >&2
    exit 1
  fi

  read -p "Description: " description
  read -p "Location: " location
  read -p "Due time (HH:MM): " due_time

  id=$(date +%s)
  echo "$id|$title|$description|$location|$due_date|$due_time|0" >> "$TODO_FILE"
  echo "Task created with ID $id"
}

# Function to update a task
update_task() {
  read -p "Task ID to update: " id
  if ! grep -q "^$id|" "$TODO_FILE"; then
    echo "Task ID not found" >&2
    exit 1
  fi

  read -p "Title: " title
  read -p "Description: " description
  read -p "Location: " location
  read -p "Due date (YYYY-MM-DD): " due_date
  read -p "Due time (HH:MM): " due_time
  read -p "Completed (0/1): " completed

  new_task="$id|$title|$description|$location|$due_date|$due_time|$completed"
  sed -i "/^$id|/c\\$new_task" "$TODO_FILE"
  echo "Task $id updated"
}

# Function to delete a task
delete_task() {
  read -p "Task ID to delete: " id
  if ! grep -q "^$id|" "$TODO_FILE"; then
    echo "Task ID not found" >&2
    exit 1
  fi

  sed -i "/^$id|/d" "$TODO_FILE"
  echo "Task $id deleted"
}

# Function to show a task
show_task() {
  read -p "Task ID to show: " id
  grep "^$id|" "$TODO_FILE" || { echo "Task ID not found" >&2; exit 1; }
}

# Function to list tasks for a given day
list_tasks() {
  read -p "Date (YYYY-MM-DD): " date
  echo "Completed tasks:"
  grep "|$date|" "$TODO_FILE" | awk -F'|' '$7==1 {print $0}'
  echo "Uncompleted tasks:"
  grep "|$date|" "$TODO_FILE" | awk -F'|' '$7==0 {print $0}'
}

# Function to search tasks by title
search_tasks() {
  read -p "Title to search: " title
  grep "|$title|" "$TODO_FILE"
}

# Main script logic
case "$1" in
  create) create_task ;;
  update) update_task ;;
  delete) delete_task ;;
  show) show_task ;;
  list) list_tasks ;;
  search) search_tasks ;;
  *)
    # If no arguments are provided, list today's tasks
    if [ $# -eq 0 ]; then
      today=$(date +%F)
      echo "Today's tasks:"
      list_tasks "$today"
    else
      usage
    fi
    ;;
esac
 code