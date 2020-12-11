FROM #IMAGE_NAME# # Replaced by sed in tests, see test_from_dockerfile in test/run

# Add application sources
ADD app-src .

# Install the dependencies
RUN pip install -U "pip>=19.3.1" && \
    pip install -r requirements.txt && \
    python manage.py collectstatic --noinput && \
    python manage.py migrate

# Fix permissions for openshift
# This is actually not needed here because our testing app
# works in read-only mode and possible failure won't cause
# the build process to stop. This is here just for documentation.
# RUN /usr/bin/fix-permissions ./

# Run the application
CMD python manage.py runserver 0.0.0.0:8080
