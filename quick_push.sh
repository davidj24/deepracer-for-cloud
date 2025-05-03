#!/bin/bash

# Check for model name and commit message
if [ $# -lt 2 ]; then
  echo "Usage: ./quick_push.sh <model_name> <commit_message>"
  exit 1
fi

MODEL_NAME=$1
COMMIT_MSG=$2

# Step 1: Run upload-car.sh with source
echo "Running dr-upload-car.sh..."
./scripts/upload/upload-car.sh -L -f -s models/${MODEL_NAME}

# Step 2: Create directory
echo "Creating directory models/$MODEL_NAME..."
mkdir -p models/$MODEL_NAME

# Step 3: Copy artifacts if they exist
echo "Copying files into models/$MODEL_NAME..."
cp tmp/car_upload/model/carfile.tar.gz models/$MODEL_NAME/ || echo "Missing carfile.tar.gz"
cp tmp/car_upload/model/model_metadata.json models/$MODEL_NAME/ || echo "Missing model_metadata.json"
cp custom_files/reward_function.py models/$MODEL_NAME/ || echo "Missing reward_function.py"

# Step 4: Git add, commit, push
echo "Adding changes to Git..."
git add models/ run.env system.env custom_files/

echo "Committing..."
git commit -m "$COMMIT_MSG" || echo "Nothing to commit."

echo "Pushing to GitHub..."
git push