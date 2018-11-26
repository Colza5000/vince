# Vince 

<p align="center">
  <img src="misc/vince.jpeg">
</p>

Create OpenVPN AMI

Following variables need to be set

```
AWS_ACCESS_KEY_ID=abcxyz
AWS_SECRET_ACCESS_KEY=abcxyz
AWS_VPC_ID=vpc-abcxyz
AWS_AMI_USERS=colza5000
BUILD_DATE=$(date +%d%m%y)
```
Run
`packer build`