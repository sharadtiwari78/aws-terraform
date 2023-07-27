resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.bucket
  bucket_prefix = var.bucket_prefix

  force_destroy       = var.force_destroy
  object_lock_enabled = var.object_lock_enabled

  tags = var.tags
}

resource "aws_s3_bucket_acl" "s3-bucket_acl" {

  bucket                = aws_s3_bucket.s3_bucket.id
  acl                   = var.acl
  expected_bucket_owner = var.expected_bucket_owner

  # This `depends_on` is to prevent "AccessControlListNotSupported: The bucket does not allow ACLs."
  depends_on = [aws_s3_bucket_ownership_controls.ownership_controls]
}

resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {

  bucket = aws_s3_bucket.s3_bucket.id

  versioning_configuration {
    status = try(var.versioning["enabled"] ? "Enabled" : "Suspended", tobool(var.versioning["status"]) ? "Enabled" : "Suspended", title(lower(var.versioning["status"])))
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "server_side_encryption_configuration" {
  bucket = aws_s3_bucket.s3_bucket.id

  dynamic "rule" {
    for_each = try(flatten([var.server_side_encryption_configuration["rule"]]), [])

    content {
      bucket_key_enabled = try(rule.value.bucket_key_enabled, null)

      dynamic "apply_server_side_encryption_by_default" {
        for_each = try([rule.value.apply_server_side_encryption_by_default], [])

        content {
          sse_algorithm     = apply_server_side_encryption_by_default.value.sse_algorithm
          kms_master_key_id = try(apply_server_side_encryption_by_default.value.kms_master_key_id, null)
        }
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "Public_policy" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_ownership_controls" "ownership_controls" {

  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    object_ownership = var.object_ownership
  }

  # This `depends_on` is to prevent "A conflicting conditional operation is currently in progress against this resource."
  depends_on = [
    aws_s3_bucket_public_access_block.Public_policy,
    aws_s3_bucket.s3_bucket
  ]
}

resource "aws_s3_bucket_notification" "bucket_notification" {

  bucket = var.bucket

  eventbridge = var.eventbridge
}

resource "aws_s3_bucket_policy" "aws_s3_bucket_policy" {
  count = var.attach_policy ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.bucket

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow",
        Principal = {
          Service = "events.amazonaws.com"
        },
        Action = "s3:*",
        Resource = aws_s3_bucket.s3_bucket.arn,
      },
    ]
  })
}