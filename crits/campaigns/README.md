# Changes/Additions

Commented out unused items from the [details page](templates/campaign_detail.html), as well as added new items.

---

Added in a duplication check for incoming TAXII messages.  

---

Added url_key to relationship item ([handlers.py](handlers.py))

```python
# relationship
    relationship = {
        'type': 'Campaign',
        'value': campaign_detail.id,
        'url_key': campaign_detail.get_url_key()
    }
```

---

Added RFI and source item to campaign type ([campaign.py](campaign.py))

```python
class Campaign(CritsBaseAttributes, CritsActionsDocument, Document, MartiRFIDocument, CritsSourceDocument):
```

---

Added function to return url_key ([campaign.py](campaign.py))

```python
def get_url_key(self):
    """
    Return the identifier for this item
    """
    return self.name
```

---

Can now merge TTPS ([handlers.py](handlers.py))

```python
def merge_ttp(id, ttp, analyst, date):
```

---

Can now merge aliases ([handlers.py](handlers.py))

```python
if merge:
    campaign.merge_aliases(tags)
else:
    campaign.set_aliases(tags)
```


# Bug fix

Added in a limiter so that campaigns wouldn't crash ([forms.py](forms.py))

```python
alphanumeric = RegexValidator(r'^[0-9a-zA-Z]*$', 'Only aphanumeric characters are allowed.')
campaign = forms.CharField(widget=forms.TextInput, required=True, validators=[alphanumeric])
```

---

Added a date check to TTPS ([campaign.py](campaign.py))

```python
if isinstance(ttp_item, EmbeddedTTP):
    found = False
    for ttp in self.ttps:
        if ttp.ttp == ttp_item.ttp:
            if ttp.date:
                if ttp.date == ttp_item.date:
                    found = True
            else:
                found = True
    if not found:
        self.ttps.append(ttp_item)
```