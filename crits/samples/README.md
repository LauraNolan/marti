# Changes/Additions

Commented out unused items from the [details page](templates/samples_detail.html), as well as added new items.

---

Added in a duplication check for incoming taxii messages.  

---

Added url_key to relationship item ([handlers.py](handlers.py))

```python
# relationship
    relationship = {
        'type': 'Sample',
        'value': sample.id,
        'url_key': sample.get_url_key()
    }
```

---

Set the releasability flag on filename update. ([views.py](views.py))

```python
set_releasability_flag('Sample', id_, analyst)
```

---

Made the default add sample form as raw with metadata vs uploading a file. ([forms.py](forms.py))

---

Added RFI item to samples type ([sample.py](sample.py))

```python
class Sample(CritsBaseAttributes, CritsSourceDocument, CritsActionsDocument,
             Document, MartiRFIDocument):
```

---

Added function to return url_key ([sample.py](sample.py))

```python
def get_url_key(self):
    """
    Return the identifier for this item
    """
    return self.md5
```