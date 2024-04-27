# Reverse Generate Terraform [link](https://www.youtube.com/watch?v=KzJsJHg3ftk)

- First of all we need create infra using `terraform apply` command in our concreteDetection app and run the concreteDetection app.

```
terraform init
```

```
terraform apply -auto-approve
```

![Terraform Apply](/Screenshots/terraformApply.png)

![run app](/Screenshots/runApp.png)

- Now created this root location dir named `Generate-resource` then created `generate.tf` file which is copy of our old main.tf file from concreteDetection/terraform and paste.
- Now go to concreteDetection/terraform and run `terraform show` command so it will show you the configuration which you created in terraform apply command.
- Now we've to give below commands in this root location to import that concreteDetection app's infra.
- First we will import crack-detection-cluster using below command.

```
terraform init
```


```
terraform import google_container_cluster.crack-detection-cluster projects/concrete-detection-5/locations/us-central1-a/clusters/crack-detection-cluster
```

![Terraform Import](/Screenshots/import-k8s-cluster.png)

- Now we will import compute disk.

```
terraform import google_compute_disk.concrete-gce-nfs-disk projects/concrete-detection-5/zones/us-central1-a/disks/concrete-gce-nfs-disk
```

![Terraform Import](/Screenshots/import-compute-disk.png)

- Now we have properly imported all infra from the concreteDetection terraform.

- So now we can destroy these resources along with concreteDetection application from concreteDetection app.

```
terrafor destroy -auto-approve
```

![Terraform Destroy](/Screenshots/destroyTerraformApp.png)

- Again we will create infra from here.

![Terraform Apply](/Screenshots/terraformApply.png)

- Then we will run our concreteDetection application which is another directory.

![run app](/Screenshots/runApp.png)

- And I've run the app from that concreteDetection dir and infra is created from this reverse genrated tf file and it running successfully as well.
