import android.view.LayoutInflater
import android.widget.Button
import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView
import com.eserdeiro.common_impls.R
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import com.wortise.ads.flutter.natives.GoogleNativeAdFactory

class NativeCardAd(private val layoutInflater: LayoutInflater) : GoogleNativeAdFactory {

    override fun createNativeAd(nativeAd: NativeAd): NativeAdView {
        val adView = layoutInflater.inflate(R.layout.my_native_card_ad, null) as NativeAdView

        val headlineView = adView.findViewById<TextView>(R.id.headline_card)
        val bodyView = adView.findViewById<TextView>(R.id.body_card)
        val mediaView = adView.findViewById<MediaView>(R.id.media_view)
        val imageView = adView.findViewById<ImageView>(R.id.image_card)
        val ratingBar = adView.findViewById<RatingBar>(R.id.star_rating_card)
        val ctaButton = adView.findViewById<Button>(R.id.cta_button_card)

        // Verify title
        nativeAd.headline?.let {
            headlineView.text = it
            adView.setHeadlineView(headlineView)
        }

        // Verify body
        nativeAd.body?.let {
            bodyView.text = it
            adView.setBodyView(bodyView)
        }

        // Verify media content
        if (nativeAd.mediaContent != null) {
            mediaView.mediaContent = nativeAd.mediaContent
            mediaView.visibility = MediaView.VISIBLE
            imageView.visibility = ImageView.GONE
            adView.setMediaView(mediaView)
        } else if (nativeAd.images.isNotEmpty() && nativeAd.images[0].drawable != null) {
            imageView.setImageDrawable(nativeAd.images[0].drawable)
            imageView.visibility = ImageView.VISIBLE
            mediaView.visibility = MediaView.GONE
            adView.setImageView(imageView)
        } else {
            imageView.visibility = ImageView.GONE
            mediaView.visibility = MediaView.GONE
        }

        // Verify button
        nativeAd.callToAction?.let {
            //            ctaButton.text = it
            ctaButton.visibility = Button.VISIBLE
            ctaButton.setBackgroundResource(R.drawable.ic_arrow_downward)
            adView.setCallToActionView(ctaButton)
        }
                ?: run { ctaButton.visibility = Button.GONE }

        // Verify star rating
        nativeAd.starRating?.let {
            if (it >= 0.0) {
                ratingBar.rating = it.toFloat()
                ratingBar.visibility = RatingBar.VISIBLE
            } else {
                ratingBar.visibility = RatingBar.GONE
            }
        }
                ?: run { ratingBar.visibility = RatingBar.GONE }

        adView.setNativeAd(nativeAd)
        return adView
    }
}
