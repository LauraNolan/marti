# Changes/Additions

Commented out unused items from the [details page](templates/email_detail.html), as well as added new items.

---

Added in a duplication check for incoming TAXII messages.  

---

Added url_key to relationship item ([handlers.py](handlers.py))

```python
# relationship
    relationship = {
        'type': 'Email',
        'value' : email.id,
        'url_key': email.get_url_key()
    }
```

---

Updated relationship link to use url_key ([email_listing_mini_widget.html](templates/email_listing_mini_widget.html))

```html
{% for rel in rel_list %}
<tr mtype="{{ relationship.type }}" mvalue="{{ relationship.url_key }}" rtype="{{ rel_type }}"...
```

---

Added RFI item to email type ([email.py](email.py))

```python
class Email(CritsBaseAttributes, CritsSourceDocument, CritsActionsDocument,
            Document, MartiRFIDocument):
```

---

Added function to return url_key ([email.py](email.py))

```python
def get_url_key(self):
    """
    Return the identifier for this item
    """
    return self.message_id
```

---

Set the repeatability flag to true when the user updates the header value of the email. ([views.py](views.py))

```python
set_releasability_flag('Email', email_id, analyst)
```

# Bug Fix

Fixed email duplication by generating new message_id if one wasn't entered (this is the email url_key) ([handlers.py](handlers.py))

```python
#Generate our own message id
from_addr = data.get('from_address', None)
date_time = data.get('date', None)
rand_int = str(random.randint(1000,9999))
try:
    s = (from_addr if from_addr else "") + date_time + rand_int
except:
    date_time = date_time.strftime("%Y-%m-%d %H:%M:%S")
    s = (from_addr if from_addr else "") + date_time + rand_int
d = hashlib.md5(s).hexdigest()
#d = s.encode('base64').rstrip().replace("=", '') #the encode likes to add '==\n' at the end and this breaks the gui
new_message_id = "CRITs_internal_" + d
data.update({'message_id':new_message_id})
```
