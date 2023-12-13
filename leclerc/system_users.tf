resource "linux_group" "remote" {
  name = "remote"
}

resource "linux_user" "remote" {
  name = "remote"
  gid = linux_group.remote.gid
}