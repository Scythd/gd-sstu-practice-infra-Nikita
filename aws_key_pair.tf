resource "aws_key_pair" "bastion-key" {
  key_name   = "bastion-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDAb6iQcNLMnaShMVTtrOxLKfAvt1OloVQWvDdpAtKSvoGolF5STsM3BKG4EngfngDwHlnTZjg8n/FFt5gB8dFyyr9wExTRcQU1m23PsT9/Fk5a/I/OlpHwe7xNr6eAARFmpDXaE6yd4GAFmIYJNGxq0+B7dZsX1VDgygq+U+CkD0/6922dqL8Td85uF2KtEtdDnpcxbXnEQepO+vg4ZW4S+EetC3UjLvbBDTte0HDEE0cBgNyU64ROz8kvKnOeB1gBV0D7elPi0uvrnjHEhypT7ztGuwC5C7cceJq4ItRIq+e9F6ZdrEVefNBIiCikQMbcCbPCrVBoYp1mtxrSirb Пользователь@MSI"
}