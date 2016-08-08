# New items

A couple new items were added to the core functionality. To do this the database (low level) was added to the mongoengine, functions in handlers called those and the views utalized the handlers.

[crits_mongoengine.py](crits_mongoengine.py) -> [handlers.py](handlers.py) -> [views.py](views.py) -> html templates

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





---
---


{% with rfi=domain.rfi %}
            {% include 'rfi_list_widget.html' %}
        {% endwith %}
        
        
        
        {% with tlp=domain.tlp %}
            {% include 'tlp_list_widget.html' %}
        {% endwith %}
        
        {% with kill_chain=domain.kill_chain %}
                {% include "kill_chain_widget.html" %}
            {% endwith %}
            
            
            {% with sightings=domain.sightings %}
                 {% include 'sightings_list_widget.html' %}
            {% endwith %}
            
            
---
            
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