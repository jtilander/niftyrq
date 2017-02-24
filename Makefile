TAG?=latest
IMAGENAME?=jtilander/niftyrq

.PHONY: image push

image:
	docker build -t $(IMAGENAME):$(TAG) .
	docker images $(IMAGENAME):$(TAG)

push: image
	docker push $(IMAGENAME):$(TAG) .
