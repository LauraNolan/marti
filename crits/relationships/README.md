# Changes/Additions
Relationships are now based off of the url_key

```python
relationship = {'type': cleaned_data.get('forward_type'),
                'url_key': cleaned_data.get('forward_value')}
```

```python
#Always check for class from value first
rel_item = class_from_value(right_type, right_id)
if not rel_item:
    rel_item = class_from_id(right_type, right_id)
```

___

Relationships can be added without both items existing. This allows for items coming in through the taxii_service to send relationships without having to send the entire item.

If an item is related to an item that doesn't exist, the link on the details page will just not point to anything. As soon as the item is in the database, the link will become active and the new item will get the relationship on it's end as well.

---

Added a TAXII trigger. This is done simply by setting the releasability flag when a new relationship is formed. 

```python
 set_releasability_flag(cleaned_data.get('forward_type'), cleaned_data.get('forward_value'), request.user.username)
```

# Bug fix

Capitalized the relationship type to make it easier to plug into the STIX message. 

```python
if new_confidence not in ('Unknown', 'Low', 'Medium', 'High'):
```

