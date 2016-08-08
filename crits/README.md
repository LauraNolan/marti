If you want to add a feature that is across all TLOs, you will add it to core and then have to add the function calls and html elements to each individual TLO.

## Simplifications
To simplify CRITs some of the types were commented out, you can uncomment them to use them. 

[settings.py](settings.py)

```python
# CRITs Types
CRITS_TYPES = {
#    'Actor': COL_ACTORS,
#    'AnalysisResult': COL_ANALYSIS_RESULTS,
#    'Backdoor': COL_BACKDOORS,
     'Campaign': COL_CAMPAIGNS,
#    'Certificate': COL_CERTIFICATES,
     'Comment': COL_COMMENTS,
     'Domain': COL_DOMAINS,
     'Email': COL_EMAIL,
#    'Event': COL_EVENTS,
#    'Exploit': COL_EXPLOITS,
#    'Indicator': COL_INDICATORS,
     'IP': COL_IPS,
     'Notification': COL_NOTIFICATIONS,
#    'PCAP': COL_PCAPS,
#    'RawData': COL_RAW_DATA,
     'Sample': COL_SAMPLES,
     'Screenshot': COL_SCREENSHOTS,
#    'Signature': COL_SIGNATURES,
#    'Target': COL_TARGETS,
}
```