import xml.etree.cElementTree as ET
import pprint
import re
import codecs
import json
import pdb


lower = re.compile(r'^([a-z]|_)*$')
lower_colon = re.compile(r'^([a-z]|_)*:([a-z]|_)*$')
problemchars = re.compile(r'[=\+/&<>;\'"\?%#$@\,\. \t\r\n]')

street_type_re = re.compile(r'\b\S+\.?$', re.IGNORECASE)

CREATED = [ "version", "changeset", "timestamp", "user", "uid"]

# UPDATE THIS VARIABLE
mapping = { "Ave.": "Ave",
            "Abenue": "Ave",
            "ave": "Ave",
            "avenue": "Ave",
            "Avenue": "Ave",
            "Blvd,": "Blvd",
            "Blvd.": "Blvd",
            "Boulavard": "Blvd",
            "Boulvard": "Blvd",
            "Boulevard": "Blvd",
            "broadway": "Broadway",
            "bush": "Bush",
            "Cres": "Crescent",
            "Ctr": "Center",
            "Court": "Ct",
            "Dr.": "Dr",
            "Drive": "Dr",
            "Hwy": "Highway",
            "Ln.": "Ln",
            "Lane": "Ln",
            "Plz": "Plaza",
            "parkway": "Parkway", 
            "Rd.": "Rd",
            "Road": "Rd",
            "Steet": "St",
            "St.": "St",
            "st": "St",
            "street": "St",
            "Street": "St",
            "square": "Square",
            "sutter": "Sutter" }


def update_street_name(name, mapping):
    """
    converts a single entry of street name to the appropriate
    name
    INPUT: streetname, mapping
    OUTPUT: appropriate name
    """
    # YOUR CODE HERE
    try: # find the last word
        k = street_type_re.search(name)
        old = k.group()
        if old not in mapping.keys():
            print 'last word case'
            return name
        else:
            new = mapping[old]
            print 'last word case'
            return name.replace(old, new)
    except AttributeError: # if cannot find the last word
        return name
    

def update_postal_code(code):
    """
    converts a single entry of postal code to the appropriate
    postal code
    INPUT: postal code
    OUTPUT: appropriate postal code
    """
    if len(code) != 5:
        n_string = code.strip('CA:').strip()
        index = n_string.find('-')
        if index > 0:
            return n_string[0:index]
        elif len(n_string) != 5:
            return ''
        else:
            return n_string
    else:
        return code
    
    
def shape_element(element):
    node = {}
    node['created'] = {}
    node['address'] = {}
    node['node_refs'] = []
    node['pos'] = [0, 0]

    if element.tag == "node" or element.tag == "way" :
        for tag in element.iter():
            
            if tag.tag == 'tag': # if it is a secondary tag
                key = tag.get('k')
                if re.search(lower, key):
                    node[key] = tag.get('v')

                elif re.search(lower_colon, key):
                    if key[0:4] == 'addr':
                        if type(node['address']) != type({}): # not sure why it's not dict
                            node['address'] = {}
                        
                        if key[5:] == 'street': # if street case
                            print 'street case'
                            print update_street_name(tag.get('v'), mapping)
                            
                            node['address'][key[5:]] = update_street_name(tag.get('v'),
                                                                          mapping)
                            
                        elif key[5:] == 'postcode': # if postal code case
                            print 'postcode'
                            print update_postal_code(tag.get('v'))
                            
                            node['address'][key[5:]] = update_postal_code(tag.get('v'))
                            
                        else: # not street or postal case
                            node['address'][key[5:]] = tag.get('v')
                    
                    else:
                        node[key] = tag.get('v')

                elif re.search(problemchars, key):
                    print 'problematic', key
                else:
                    print 'else', key
            
            else:
                node['type'] = element.tag

                for k, v in tag.attrib.iteritems():
                    if k in CREATED:
                        node['created'][k] = v

                    elif k == 'lat':
                        node['pos'][0] = float(v)

                    elif k == 'lon':
                        node['pos'][1] = float(v)

                    elif k == 'user':
                        pass

                    elif k == 'ref' and element.tag == 'way':
                        node['node_refs'].append(v)

                    else: 
                        node[k] = v

        if node['address'] == {}:
            del node['address']
            
        if len(node['node_refs']) == 0:
            del node['node_refs']
        
#         print node
        return node
    else:
        return None


def process_map(file_in, pretty = False):
    # You do not need to change this file
    file_out = "{0}.json".format(file_in)
    data = []
    with codecs.open(file_out, "w") as fo:
        i = 0
        for _, element in ET.iterparse(file_in):
            i += 1
            print 'iteration: ', i
            el = shape_element(element)
            if el:
                data.append(el)
                if pretty:
                    fo.write(json.dumps(el, indent=2)+"\n")
                else:
                    fo.write(json.dumps(el) + "\n")
    # return data


if __name__ == "__main__":
    process_map('san-francisco.osm', False)