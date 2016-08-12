# Changes/Additions

Commented out unused items from the [details page](templates/ip_detail.html), as well as added new items.

---

Added in a duplication check for incoming TAXII messages. This was done by checking to see if the received message id is the same as one that was sent.
  
```python
if ip_object.check_message_received(id):
    return {'success': False, 'message': 'dup'}
```  

---

Added url_key to relationship item ([handlers.py](handlers.py))

```python
# relationship
relationship = {
    'type': 'IP',
    'value': ip.id,
    'url_key': ip.get_url_key()
}
```

---

Added RFI item to IP type ([ip.py](ip.py))

```python
class IP(CritsBaseAttributes, CritsActionsDocument, CritsSourceDocument, Document, MartiRFIDocument):
```

---

Added function to return url_key ([ip.py](ip.py))

```python
def get_url_key(self):
    """
    Return the identifier for this item
    """
    return self.ip
```