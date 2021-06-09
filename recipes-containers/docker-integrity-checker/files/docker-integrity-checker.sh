#!/bin/sh

echo "docker-compose service has failed."

if [ ! -f "/etc/docker/enable-integrity-checker" ]; then
   echo "Docker integrity checker is disabled. Create /etc/docker/enable-integrity-checker file to enable it."
   echo "Restarting docker-compose in 10 seconds..."
   sleep 10
   systemctl restart docker-compose
   exit 1
fi

IMAGE_SHA=$(docker-compose config | grep image | sed 's/^[^:]*://g')

for IMAGE in $IMAGE_SHA
   do
      echo "Checking the integrity of the Docker images..."
      docker save "$IMAGE" > /dev/null
      if [ ! $? = 0 ]; then
         echo "Image $IMAGE seems to be corrupted."
         DIGEST=$(echo $IMAGE | sed 's/^[^@]*@//g')
         IMAGE_ID=$(echo $(docker images --format "{{.ID}}: {{.Digest}}" | grep $DIGEST | sed 's/:.*//'))
         docker rmi -f $IMAGE_ID
         if [ $? = 1 ]; then
            docker rmi -f $IMAGE
         fi
         echo "Image $IMAGE was removed and will be re-pulled again."

         PULL_ATTEMPT=0
         PULL_LIMIT=3
         while [ $PULL_ATTEMPT -lt $PULL_LIMIT ]
         do
            docker pull "$IMAGE"
            if [ $? = 0 ]; then
               echo "Corrupted image $IMAGE has been re-pulled successfully."
               break
            fi
            PULL_ATTEMPT=$(expr $PULL_ATTEMPT + 1)
            if [ $PULL_ATTEMPT = $PULL_LIMIT ]; then
               echo "Error pulling image $IMAGE. Please check your internet connection."
               break
            fi
            echo "Error pulling image $IMAGE. Attempt $PULL_ATTEMPT of $PULL_LIMIT."
         done
      else
         echo "Docker image $IMAGE is OK."
      fi
   done
echo " Restarting docker-compose.service."
systemctl restart docker-compose
