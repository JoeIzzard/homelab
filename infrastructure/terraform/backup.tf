resource "b2_bucket" "nebula-tn-backup" {
  bucket_name = "nebula-tn-backup"
  bucket_type = "allPrivate"
}
