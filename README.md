# Vince 

<p align="center">
  <img src="misc/vince.jpeg">
</p>

Create OpenVPN AMI

Following variables need to be set

```
export AWS_ACCESS_KEY_ID=abcxyz
export AWS_SECRET_ACCESS_KEY=abcxyz
export AWS_VPC_ID=vpc-abcxyz
export AWS_AMI_USERS=colza5000
export BUILD_DATE=$(date +%d%m%y)
```
Run
`packer build`
