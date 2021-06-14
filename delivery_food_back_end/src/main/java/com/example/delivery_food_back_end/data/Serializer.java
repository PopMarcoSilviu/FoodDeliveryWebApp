package com.example.delivery_food_back_end.data;

import java.io.*;

public class Serializer
{
    public void serialize(Serializable serializable)
    {
        try
        {
            FileOutputStream file = new FileOutputStream("src/main/resources/static/out");
            ObjectOutputStream out = new ObjectOutputStream(file);
            out.writeObject(serializable);
            out.close();
            file.close();
        } catch (IOException e)
        {
            e.printStackTrace();
        }
    }

    public Object deserialize()
    {
        Object serializable = null;
        try
        {
            FileInputStream file = new FileInputStream("src/main/resources/static/out");
            ObjectInputStream in = new ObjectInputStream(file);
            serializable = in.readObject();

            in.close();
            file.close();

        } catch (IOException | ClassNotFoundException e)
        {
            e.printStackTrace();
        }

        return serializable;
    }
}
