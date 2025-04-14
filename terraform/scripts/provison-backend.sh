#!/bin/bash

# Set variables for resource names
BUCKET_NAME="tf-state-react-jenkin-12"  # Ensure this bucket name is unique
TABLE_NAME="terraform-state-lock"
REGION="us-east-1"  # Change this to your preferred region

aws secretsmanager create-secret \
    --name "rds/sql-db-admin-pass" \
    --secret-string "Demo1234"

# Function to check if the S3 bucket exists
function bucket_exists() {
    aws s3api head-bucket --bucket "$1" 2>/dev/null
}

# Create S3 bucket if it doesn't exist
if bucket_exists "$BUCKET_NAME"; then
    echo "Bucket ${BUCKET_NAME} already exists. Skipping creation."
else
    echo "Creating S3 bucket: ${BUCKET_NAME}..."
    aws s3api create-bucket \
        --bucket "${BUCKET_NAME}" \
        --region "${REGION}" \
        $(if [ "${REGION}" != "us-east-1" ]; then echo "--create-bucket-configuration LocationConstraint=${REGION}"; fi)

    if [ $? -eq 0 ]; then
        echo "Bucket ${BUCKET_NAME} created successfully."

        # Enable versioning on the bucket
        aws s3api put-bucket-versioning \
            --bucket "${BUCKET_NAME}" \
            --versioning-configuration Status=Enabled

        # Enable server-side encryption for the bucket
        aws s3api put-bucket-encryption \
            --bucket "${BUCKET_NAME}" \
            --server-side-encryption-configuration '{
                "Rules": [
                    {
                        "ApplyServerSideEncryptionByDefault": {
                            "SSEAlgorithm": "AES256"
                        }
                    }
                ]
            }'

        # Block all public access to the bucket
        aws s3api put-public-access-block \
            --bucket "${BUCKET_NAME}" \
            --public-access-block-configuration '{
                "BlockPublicAcls": true,
                "IgnorePublicAcls": true,
                "BlockPublicPolicy": true,
                "RestrictPublicBuckets": true
            }'
    else
        echo "Failed to create S3 bucket."
        exit 1
    fi
fi

# Create DynamoDB table for state locking if it doesn't exist
if aws dynamodb describe-table --table-name "${TABLE_NAME}" 2>/dev/null; then
    echo "DynamoDB table ${TABLE_NAME} already exists. Skipping creation."
else
    echo "Creating DynamoDB table: ${TABLE_NAME}..."
    aws dynamodb create-table \
        --table-name "${TABLE_NAME}" \
        --attribute-definitions AttributeName=LockID,AttributeType=S \
        --key-schema AttributeName=LockID,KeyType=HASH \
        --billing-mode PAY_PER_REQUEST

    if [ $? -eq 0 ]; then
        echo "DynamoDB table ${TABLE_NAME} created successfully."
    else
        echo "Failed to create DynamoDB table."
        exit 1
    fi
fi

echo "Backend provisioning completed successfully."


