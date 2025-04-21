#!/bin/bash

# Check for model name and commit message
if [ $# -lt 2 ]; then
  echo "Usage: ./quick_push.sh <model_name> <commit_message>"
  exit 1
fi

MODEL_NAME=$1
COMMIT_MSG=$2

# Step 1: Run upload-car
echo "Running dr-upload-car.sh..."
./scripts/upload/upload-car.sh -L -f

# Step 2: Create new directory under models/
echo "Creating directory models/$MODEL_NAME..."
mkdir -p models/$MODEL_NAME

# Step 3: Copy model files
echo "Copying files into models/$MODEL_NAME..."
cp tmp/car_upload/model/carfile.tar.gz models/$MODEL_NAME/
cp tmp/car_upload/model/model_metadata.json models/$MODEL_NAME/
cp custom_files/reward_function.py models/$MODEL_NAME/

# Step 4: Git add, commit, push
echo "Adding changes to Git..."
git add models/ run.env system.env custom_files/

echo "Committing..."
git commit -m "$COMMIT_MSG"

echo "Pushing to GitHub..."
git push

