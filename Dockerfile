# Stage 1: Build the Jenkins plugin using Maven
FROM maven:3.9.6-eclipse-temurin-17 as builder

# Set work directory inside the container
WORKDIR /app

# Copy the Maven project into the container
COPY . .

# Build the plugin (skip tests to speed up, or remove `-DskipTests` to include tests)
RUN mvn clean install -DskipTests

# Stage 2: Jenkins plugin container (optional)
# You could use this stage to copy the resulting .hpi into a Jenkins container
# For demonstration, we'll just show how to get the .hpi plugin from stage 1

FROM alpine:3.20

# Copy the built plugin from the previous stage
COPY --from=builder /app/target/anything-goes-formatter.hpi /plugin/anything-goes-formatter.hpi

# Optional: Just show where plugin is copied
CMD ["ls", "-l", "/plugin"]
