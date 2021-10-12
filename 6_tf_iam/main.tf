locals {
    env = "demo"
    product = "devops-exercise"
}

data "aws_caller_identity" "current" {}

# IAM Role that uses current account as Trusted Entity 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role#example-of-using-data-source-for-assume-role-policy
# https://blog.container-solutions.com/how-to-create-cross-account-user-roles-for-aws-with-terraform
resource "aws_iam_role" "devops_exercise_role" {
    name  = "${local.env}-${local.product}-role"
    path  = "/${local.product}/"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect   = "Allow",
            Action   = "sts:AssumeRole",    
            Principal = { "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" }
        }]      
    })
}  

# IAM Policy that allows assuming above role 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "devops_exercise_policy" {
    name   = "${local.env}-${local.product}-policy"
    path   = "/${local.product}/"
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Effect   = "Allow",
            Action   = "sts:AssumeRole",              
            Resource = aws_iam_role.devops_exercise_role.arn
        }]
    }) 
}

# IAM Group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group
resource "aws_iam_group" "devops_exercise_group" {
    name   = "${local.env}-${local.product}-group"
    path   = "/${local.product}/"
}

# Ataching policy that allows assumming the IAM Role to IAM Group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment
resource "aws_iam_group_policy_attachment" "devops_exercise_policy_attachment" {
    group      = aws_iam_group.devops_exercise_group.name
    policy_arn = aws_iam_policy.devops_exercise_policy.arn
}

# IAM User
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user
resource "aws_iam_user" "devops_exercise_user" {
    name   = "${local.env}-${local.product}-user"
    path   = "/${local.product}/"
}


# Adding above IAM User to the IAM Group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership
resource "aws_iam_user_group_membership" "devops_exercise_user_group" {
    user   = aws_iam_user.devops_exercise_user.name
    groups = [aws_iam_group.devops_exercise_group.name]
}

# References:
# https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_identity-vs-resource.html
