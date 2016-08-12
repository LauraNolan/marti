#Additions
* Added walkthrough option to service config edit

```python
auto_inbox = forms.BooleanField(required=False,
                            label="Auto Inbox",
                            initial=False,
                            help_text="Auto send Taxii feeds.",
                            widget=forms.CheckboxInput(
                                attrs={'data-step': '8',
                                'data-intro': 'Do you want MARTI to send data to the TAXII server automatically (if released)?'})
```


#Bug Fixes
* Sevice config/edit now show up in place (vs before they showed up on a new page and you had to go back a page to get to the main GUI.

![services_fix](../../images/services_gui.gif)
