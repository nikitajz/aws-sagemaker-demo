provider "aws" {
  region  = "ap-southeast-2"
}

resource "aws_iam_role" "sagemaker_role" {
  name = "demo_role"

  assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "sagemaker.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
EOF
}

resource "aws_iam_role_policy_attachment" "attach-SageMakerFullAccess" {
    role       = "${aws_iam_role.sagemaker_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "my-sagemaker-demo-bucket"
}

output "sagemaker_role_id" {
  value = aws_iam_role.sagemaker_role.arn
}
output "s3bucket" {
  value = aws_s3_bucket.bucket.id
}