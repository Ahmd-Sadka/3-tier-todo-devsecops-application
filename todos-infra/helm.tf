resource "helm_release" "elb_controller" {
    name       = "aws-load-balancer-controller"
    repository = "https://aws.github.io/eks-charts"
    chart      = "aws-load-balancer-controller"
    namespace  = "kube-system"
    version    = "1.11.0"

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
        value = "module.vpcModule.vpc_id"
    }

    
}

resource "helm_release" "ebs_csi_driver" {
    name       = "aws-ebs-csi-driver"
    chart      = "../Charts/aws-ebs-csi-driver"
    namespace  = "kube-system"
    

}

resource "helm_release" "sonarqube" {
    name       = "sonarqube"
    chart      = "../Charts/sonarqube"
    namespace  = "sonarqube"
    create_namespace = true

    values = [ file("../Charts/sonarqube/myValues.yml") ]
    depends_on = [ helm_release.elb_controller, helm_release.ebs_csi_driver ]
}