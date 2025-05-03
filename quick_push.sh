#!/bin/bash

# Check for model name and commit message
if [ $# -lt 2 ]; then
  echo "Usage: ./quick_push.sh <model_name> <commit_message>"
  exit 1
fi

MODEL_NAME=$1
COMMIT_MSG=$2
MODEL_DIR="models/$MODEL_NAME"

# Step 1: Run upload-car.sh to generate model artifacts
echo "Running dr-upload-car.sh..."
./scripts/upload/upload-car.sh -L -f

# Check if upload generated expected files
if [ ! -f tmp/car_upload/model/carfile.tar.gz ] || [ ! -f tmp/car_upload/model/model_metadata.json ]; then
  echo "Error: carfile.tar.gz or model_metadata.json not found. Upload likely failed."
  exit 1
fi

# Step 2: Remove old model directory if it exists
if [ -d "$MODEL_DIR" ]; then
  echo "Removing existing directory $MODEL_DIR..."
  rm -rf "$MODEL_DIR"
fi

# Step 3: Create fresh directory and copy model files
echo "Creating $MODEL_DIR..."
mkdir -p "$MODEL_DIR"

echo "Copying model files into $MODEL_DIR..."
cp tmp/car_upload/model/carfile.tar.gz "$MODEL_DIR/"
cp tmp/car_upload/model/model_metadata.json "$MODEL_DIR/"
cp custom_files/reward_function.py "$MODEL_DIR/"

# Step 4: Git add, commit, and push
echo "Adding changes to Git..."
git add "$MODEL_DIR" run.env system.env custom_files/

echo "Committing..."
git commit -m "$COMMIT_MSG"

echo "Pushing to GitHub..."
git push
