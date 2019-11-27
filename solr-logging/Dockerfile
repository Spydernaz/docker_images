FROM solr:8

COPY --chown=solr:root ranger_audits /var/solr/data/ranger_audits

RUN ls -la /var/solr/data

ENTRYPOINT ["docker-entrypoint.sh"]
CMD [ "solr-precreate", "ranger_audits" ]