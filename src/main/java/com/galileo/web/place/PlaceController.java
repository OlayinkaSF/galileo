/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.galileo.web.place;

import com.galileo.web.account.PlaceRepository;
import javax.inject.Inject;
import org.android.json.JSONException;
import org.android.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Olayinka
 */
@Controller
public class PlaceController {

    private final PlaceRepository placeRepository;

    @Inject
    public PlaceController(PlaceRepository placeRepository) {
        this.placeRepository = placeRepository;
    }

    @ResponseBody
    @RequestMapping(value = "/place/update", method = RequestMethod.POST)
    public String updatePlace(String post) throws JSONException {
        JSONObject object = new JSONObject(post);
        int res = placeRepository.updatePlace(object.getString("place").trim(), object.getDouble("longitude"), object.getDouble("latitude"));
        return res == 1 ? "success" : "failure";
    }

}
