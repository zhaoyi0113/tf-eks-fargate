CLUSTER_NAME=${1:-elk}
echo "create for $CLUSTER_NAME"

# kubectl apply \
#     --validate=false \
#     -f https://github.com/jetstack/cert-manager/releases/download/v1.1.1/cert-manager.yaml

eksctl create iamserviceaccount \
  --cluster=$CLUSTER_NAME \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --attach-policy-arn=arn:aws:iam::115136697128:policy/AWSLoadBalancerControllerIAMPolicy-${CLUSTER_NAME} \
  --override-existing-serviceaccounts \
  --approve

eksctl utils associate-iam-oidc-provider --cluster elk