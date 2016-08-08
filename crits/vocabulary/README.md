Made [kill_chain](kill_chain.py) vocabulary match the STIX LCMO standards.
 
```python
RECON = str(lmco.PHASE_RECONNAISSANCE.ordinality) + ". " + lmco.PHASE_RECONNAISSANCE.name
WEAPONIZE = str(lmco.PHASE_WEAPONIZE.ordinality) + ". " + lmco.PHASE_WEAPONIZE.name
DELIVER = str(lmco.PHASE_DELIVERY.ordinality) + ". " + lmco.PHASE_DELIVERY.name
EXPLOIT = str(lmco.PHASE_EXPLOITATION.ordinality) + ". " + lmco.PHASE_EXPLOITATION.name
INSTALL = str(lmco.PHASE_INSTALLATION.ordinality) + ". " + lmco.PHASE_INSTALLATION.name
CONTROL = str(lmco.PHASE_COMMAND_AND_CONTROL.ordinality) + ". " + lmco.PHASE_COMMAND_AND_CONTROL.name
ACTIONS = str(lmco.PHASE_ACTIONS_AND_OBJECTIVES.ordinality) + ". " + lmco.PHASE_ACTIONS_AND_OBJECTIVES.name
```

I suggest that the other vocabularies be updated to match any standards as well as making sure that any new vocabularies added use standards.