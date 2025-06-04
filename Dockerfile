# Dockerfile for building MinimumViableDataspace connector images
FROM eclipse-temurin:17-jdk-alpine as builder

# Install git, bash, and other required tools
RUN apk add --no-cache git bash docker

WORKDIR /opt

# Clone the MVD repository
RUN git clone https://github.com/eclipse-edc/MinimumViableDataspace.git mvd

WORKDIR /opt/mvd

# Build the runtime images using gradle as described in the README
RUN dockerd & \
    until docker info >/dev/null 2>&1; do sleep 1; done && \
    ./gradlew build && \
    ./gradlew -Ppersistence=true dockerize && \
    pkill dockerd

# Use a minimal base image that only contains the resulting images
FROM scratch as artifacts
COPY --from=builder /opt/mvd .
