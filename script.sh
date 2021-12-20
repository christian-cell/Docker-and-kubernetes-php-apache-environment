continue=true

if $continue
then
	
	echo "INFO: Deleting Ingress Webhook validation"  && \
	kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
	echo "Success"
	echo "========================================="
fi

if $continue
then
	
	echo "INFO: Building ApachePHP image"  && \
	docker build . -f ./Dockerfile -t my-php:1.0 && \
	echo "Success" || \
	continue=false
	echo "========================================="
fi

if $continue
then

    
	
	docker tag my-php:1.0 christianphp/my-php:1.0
	docker push christianphp/my-php:1.0
	
fi



if $continue
then
	if [ $? -gt 0 ]
	then
	    echo "WARNING: There were some problems with local Docker repository"
	else
		echo "SUCCESS: Docker repository was created correctly!"
	fi
fi


if $continue
then
	# Apply all files for local kubernetes cluster
	echo "=========================================" && \
	echo "INFO: Applying Kubernetes elements" && \
	kubectl apply -f ./kubernetes/secret.yaml && \
	echo "=========================================" && \
	kubectl delete deployment apachephp-deployment
	kubectl apply -f ./kubernetes/apachephp-depl.yaml && \
	echo "=========================================" && \
	#kubectl apply -f ./kubernetes/mysql-depl.yaml && \
	echo "=========================================" && \
	#kubectl apply -f ./kubernetes/ingress.yaml
fi

if $continue
then
	if [ $? -gt 0 ]
	then
	    echo "WARNING: There were some problems with applying Kubernetes files"
	else
	    echo "SUCCESS: All Kubernetes files were applied correctly!"
	fi
fi

