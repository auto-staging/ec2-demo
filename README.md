# Auto Staging EC2 demo

> This demo is intendet to demonstrate the function of Auto Staging in combination with EC2 instances and an ALB

:warning: This repository contains references to a specific AWS account, which was used for testing Auto Staging. Additionally there may be some definitions like domains, which are hardcoded in the Terraform definitions.

## Requirements

- [stagectl](https://github.com/auto-staging/stagectl)
- Working Auto Staging system

## Commands

### Resolve dependencies

``` make
make prepare
```

### Build binary

``` make
make build
```

### Create Auto Staging repository

``` bash
stagectl add repository
```
