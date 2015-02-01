function newPopUp(lonlat, content) {
    popup = new OpenLayers.Popup.FramedCloud(
            'popup',
            lonlat,
            null,
            '<br /><b>' + content + '</b><br />',
            new OpenLayers.Icon(
                    '',
                    new OpenLayers.Size(0, 0),
                    new OpenLayers.Pixel(0, 0)
                    ),
            true,
            null
            );
    popup.minSize = new OpenLayers.Size(200, 40);
    popup.maxSize = new OpenLayers.Size(350, 300);
    popup.autoSize = true;
    popup.offset = 7;

    popup.calculateNewPx = function (px) {
        if (popup.size !== null) {
            px = px.add(popup.size.w / 2 * -1 + popup.offset, popup.size.h * -1 + popup.offset);
            return px;
        }
    };

    popup.getSafeContentSize = function (size) {
        var new_h;
        var new_w;
        // make sure the popup isn't being sized too large or small.
        // if it is find which of the limits are closer.
        if (size.w > popup.maxSize.w || size.w < popup.minSize.w) {
            new_w = closestTo(size.w, [popup.maxSize.w, popup.minSize.w]);
        } else {
            new_w = size.w;
        }
        if (size.h > popup.maxSize.h || size.h < popup.minSize.h) {
            new_h = closestTo(size.h, [popup.maxSize.h, popup.minSize.h]);
        } else {
            new_h = size.h;
            // becuase of the way openlayers calculates the height for the internal content 
            // of a popup it's possible to adjust the width down to the min which pushes
            // the content down beyond the originally calculated height.
            // anything with a height greater than 113 seemed to have this problem so I'm just
            // adding a flat 35 pixels to keep the overflow from occurring
            if (size.h > 113) {
                new_h += 35;
            }
        }
        // build a new size object with the new_h and new_w vars and return it.
        return new OpenLayers.Size(new_w, new_h);
    };

    return popup;
}
function closestTo(number, set) {
    var closest = set[0];
    var prev = Math.abs(set[0] - number);
    for (var i = 1; i < set.length; i++) {
        var diff = Math.abs(set[i] - number);
        if (diff < prev) {
            prev = diff;
            closest = set[i];
        }
    }
    return closest;
}