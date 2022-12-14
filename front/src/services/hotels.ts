import { Numeral } from 'numeral';
import { Hotels } from 'src/models/hotels';
import api from './api';

export const findAll = async () => {
  try {
    const response = await api.get('/hotels');
    // console.log(response);
    return response.data as Hotels[];
  } catch (error) {
    console.error(error);
    return [];
  }
};

export const findOne = async (id) => {
  const response = await api.get(`/hotel/${id}`);
  return response.data.hotel as Hotels;
};

export const create = async (data) => {
  console.log(data);
  const response = await api.post('/hotels/',data);
  console.log("fasd");
  return response.data as Hotels;
};

export const update = async (id, data) => {
  try {
    const response = await api.patch(`/hotel/${id}`, data);
    return response;
  } catch (error) {
    return error;
  }
};

export const remove = async (id) => {
  const response = await api.delete(`/hotels/${id}`);
  return response.data as Hotels;
};
