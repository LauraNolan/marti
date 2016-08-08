# New items

A couple new items were added to the core functionality. To do this the database (low level) was added to the mongoengine, functions in handlers called those and the views utalized the handlers.

[crits_mongoengine.py](crits_mongoengine.py) -> [handlers.py](handlers.py) -> [views.py](views.py) -> html templates

Below the function names and descriptions will be listed, but I encourage you to look over the entire function to see how everything works together.

---

## Sightings

---

[crits_mongoengine.py](crits_mongoengine.py)

```python
class Sightings(EmbeddedDocument, CritsDocumentFormatter):
    """
    Sightings class
    """

    class SightingInstance(EmbeddedDocument, CritsDocumentFormatter):
        """
        Sightings Instance Class
        """

        name = StringField()
        date = DateTimeField()

    sighting = BooleanField()
    date = DateTimeField()
    instances = ListField(EmbeddedDocumentField(SightingInstance))
```

```python
def set_sighting(self, date, value):
    """
    Set the organizations sighting to this top-level object.

    :param value: The value of the sighting
    :type value: T/F
    :param date: The date of the sighting
    :type date:  DateTimeField
    :returns: dict with keys "success" (boolean) and "message" (str)
    """
    ...

def add_sighting(self, name, date):
    """
    Add a sighting to this top-level object.

    :param name: The name of the organization to add.
    :type name: :class:`crits.core.crits_mongoengine.SightingInstance` or string
    :param date: The date of the sighting
    :type date:  DateTimeField
    :returns: dict with keys "success" (boolean) and "message" (str)
    """
    ...
```

---

[handlers.py](handlers.py)

```python
def set_sighting(type_, id_, date, value, user):
    """
    Set sighting of a top-level object.

    :param type_: The CRITs type of the top-level object.
    :type type_: str
    :param id_: The ObjectId to search for.
    :type id_: str
    ;param date: The date of the sighting
    ;type date:  DateTime
    :param value: The value of the sighting. (T/F)
    :type value: boolean
    :param user: The user adding the sighting.
    :type user: str
    :returns: dict with keys "success" (boolean) and "message" (str)
    """
    ...

def add_sighting(type_, id_, name, date, user):
    """
    Add sighting to a top-level object.

    :param type_: The CRITs type of the top-level object.
    :type type_: str
    :param id_: The ObjectId to search for.
    :type id_: str
    :param name: The organization to add sighting for.
    :type name: str
    ;param date: The date of the sighting
    ;type date:  DateTime
    :param user: The user adding the sighting.
    :type user: str
    :returns: dict with keys "success" (boolean) and "message" (str)
    """
    ...
```

---

[views.py](views.py)

```python
def source_sighting(request):
    """
    Modify a top-level object's sightings. Should be an AJAX POST.

    :param request: Django request.
    :type request: :class:`django.http.HttpRequest`
    :returns: :class:`django.http.HttpResponse`
    """
    ...
    #Set or reset sighting
    if action == 'set':
        result = set_sighting(type_, id_, datetime.datetime.now(tzutc()), True, user)
        set_releasability_flag(type_, id_, user)
    else:
        result = set_sighting(type_, id_, datetime.datetime.now(tzutc()), False, user)
    
```

---

To add to a TLO, add the following to the details page (the exmple below is for a domain, modify accordingly).

```html
{% with sightings=domain.sightings %}
     {% include 'sightings_list_widget.html' %}
{% endwith %}
```

---
---

## TLP

---

[crits_mongoengine.py](crits_mongoengine.py)

```python

```

```python

```

---

[handlers.py](handlers.py)

```python

```

---

[views.py](views.py)

```python
 
    
```

---

To add to a TLO, add the following to the details page (the exmple below is for a domain, modify accordingly).

```html
{% with tlp=domain.tlp %}
    {% include 'tlp_list_widget.html' %}
{% endwith %}
```

---
---

## RFI

---

[crits_mongoengine.py](crits_mongoengine.py)

```python

```

```python

```

---

[handlers.py](handlers.py)

```python

```

---

[views.py](views.py)

```python
 
    
```

---

To add to a TLO, add the following to the details page (the exmple below is for a domain, modify accordingly).

```html
{% with rfi=domain.rfi %}
    {% include 'rfi_list_widget.html' %}
{% endwith %}
```

---
---

## Kill Chain

---

[crits_mongoengine.py](crits_mongoengine.py)

```python

```

```python

```

---

[handlers.py](handlers.py)

```python

```

---

[views.py](views.py)

```python
 
    
```

---

To add to a TLO, add the following to the details page (the exmple below is for a domain, modify accordingly).

```html
{% with kill_chain=domain.kill_chain %}
    {% include "kill_chain_widget.html" %}
{% endwith %}
```

# Changes/Additions
            
Check to make sure MD5 is 32bit ([data_tools.py](data_tools.py))
   
```python
if re.match("^[a-fA-F0-9]{32}$", md5_checksum) == None:
    input_len = str(len(md5_checksum))
    retVal['message'] += "The MD5 digest needs to be 32 hex characters. Input was " + input_len + " characters long."
    retVal['success'] = False
```
            
---

Made email id the message_id ([class_mapper.py](class_mapper.py))

---

Added urls for killchain, rfi, tlo, and sightings ([urls.py](urls.py))

---

Updated dowload options to include intrep ([forms.py](forms.py))

```python
rst_fmt = forms.ChoiceField(choices=[("zip", "zip"),
                                     ("json", "JSON"),
                                     ("json_no_bin", "JSON (no binaries)"),
                                     ("intrep_docx","INTREP (word doc)"),
                                     ("intrep_txt","INTREP (txt doc)")],
                                     label="Result format")
```