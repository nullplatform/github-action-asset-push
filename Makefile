.PHONY: push-docker-image push-lambda

push-docker-image:
	docker tag $(ASSET_NAME):latest $(ASSET_TARGET_URL)
	docker push $(ASSET_TARGET_URL)

push-lambda:
	aws s3 cp $(ASSET_OUTPUT_DIRECTORY)/$(ASSET_NAME).zip $(ASSET_TARGET_URL)
