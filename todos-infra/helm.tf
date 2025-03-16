resource "helm_release" "elb_controller" {
    name       = "aws-load-balancer-controller"
    repository = "https://aws.github.io/eks-charts"
    chart      = "aws-load-balancer-controller"
    namespace  = "kube-system"
    version    = "1.11.0"

    set {
        name  = "clusterName"
        value = module.eksModule.eks_cluster_name
    }

    depends_on = [module.eksModule]
    
}

resource "helm_release" "ebs_csi_driver" {
    name       = "aws-ebs-csi-driver"
    chart      = "../Charts/aws-ebs-csi-driver"
    namespace  = "kube-system"
    

    depends_on = [ module.eksModule ]

}

resource "helm_release" "sonarqube" {
    name       = "sonarqube"
    chart      = "../Charts/sonarqube"
    namespace  = "sonarqube"
    create_namespace = true

    values = [ file("../Charts/sonarqube/myValues.yml") ]
    depends_on = [ module.eksModule, helm_release.elb_controller, helm_release.ebs_csi_driver ]
}