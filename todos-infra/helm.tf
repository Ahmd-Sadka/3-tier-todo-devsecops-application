resource "helm_release" "elb_controller" {
    name       = "aws-load-balancer-controller"
    repository = "https://aws.github.io/eks-charts"
    chart      = "aws-load-balancer-controller"
    namespace  = "kube-system"
    

    set {
        name  = "clusterName"
        value = "zephyr-eks"
    }

    set {
        name  = "region"
        value = "us-east-1"
    }

    set {
        name  = "vpcId"
        value = module.vpcModule.vpc_id
    }

    set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
    }
    

    set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.eksModule.aws_load_balancer_controller_role_arn
    }
    
  }



resource "helm_release" "ebs_csi_driver" {
    name       = "aws-ebs-csi-driver"
    chart      = "../Charts/aws-ebs-csi-driver"
    namespace  = "kube-system"

    set {
      name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = module.eksModule.ebs_csi_role_arn
    }
    
}

# resource "helm_release" "argo-cd" {
#     depends_on = [ helm_release.elb_controller ]
#     name       = "argo-cd"
#     chart      = "../Charts/argo-cd"
#     namespace  = "argocd"
#     create_namespace = true

#     values = [
#         file("../Charts/argo-cd/argocd-values.yml")
#     ]
  
# }