# Changes/Additions

Commented out unused items from the [details page](templates/domain_detail.html), as well as added new items.

---

Added in a duplication check for incoming TAXII messages.  

---

Added url_key to relationship item ([handlers.py](handlers.py))

```python
# relationship
    relationship = {
        'type': 'Domain',
        'value': dmain.id,
        'url_key': dmain.get_url_key()
    }
```

---

Added RFI item to domain type ([domain.py](domain.py))

```python
class Domain(CritsBaseAttributes, CritsSourceDocument, CritsActionsDocument,
             Document, MartiRFIDocument):
```

---

Added function to return url_key ([domain.py](domain.py))

```python
def get_url_key(self):
    """
    Return the identifier for this item
    """
    return self.domain
```